// ignore_for_file: always_specify_types

import "dart:io";

import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pizza_hut_client_mobile/constants/constants.dart";
import "package:pizza_hut_client_mobile/core/error/failure.dart";
import "package:pizza_hut_client_mobile/core/local_source/hive_database.dart";
import "package:pizza_hut_client_mobile/core/mixins/cache_mixin.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/banners_response.dart";
import "package:pizza_hut_client_mobile/features/home/data/models/tags_response.dart";
import "package:pizza_hut_client_mobile/features/home/domain/entities/category_entity.dart";
import "package:pizza_hut_client_mobile/features/home/domain/repository/home_repository.dart";
import "package:pizza_hut_client_mobile/features/profile/domain/entities/promo_entity.dart";
import "package:pizza_hut_client_mobile/injector_container.dart";

part "home_event.dart";

part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> with CacheMixin {
  HomeBloc({
    required this.repository,
  }) : super(const HomeState()) {
    on<BannersEvent>(_onBanners);
    on<ShipperEvent>(_onShipper);
    on<TagsAllEvent>(_onTagsAll);
    on<TagSelectedEvent>(_onTagSelected);
    on<CategoriesWithProductEvent>(_onCategoriesWithProduct);
    on<FilterSubmitEvent>(_onFilterSubmit);
    on<FilterResetEvent>(_onFilterReset);
  }

  final HomeRepository repository;

  Future<void> _onFilterReset(
    FilterResetEvent event,
    Emitter<HomeState> emit,
  ) async {
    final List<Tags> tags = state.tags;
    for (int i = 0; i < tags.length; i++) {
      tags[i] = tags[i].copyWith(isSelected: false);
    }
    emit(state.copyWith(tags: tags, isLoading: true));
    await _onCategoriesWithProduct(const CategoriesWithProductEvent(), emit);
  }

  Future<void> _onFilterSubmit(
    FilterSubmitEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(tags: event.tags));
    final result = await repository.getProducts(
      queryParameters: {
        "tag_ids": event.tags
            .where((element) => element.isSelected)
            .map((e) => e.id)
            .toList()
            .join(","),
      },
    );
    result.fold(
      (l) {},
      (r) {
        final CategoryEntity category = CategoryEntity(
          id: "0",
          title: const MultiTitle(
            en: "Filtered",
            ru: "Фильтрованные",
            uz: "Filtrlanganlar",
          ),
          products: r,
        );
        emit(state.copyWith(categories: [category]));
      },
    );
  }

  void _onTagSelected(TagSelectedEvent event, Emitter<HomeState> emit) {
    final List<Tags> tags = state.tags;
    tags[event.index] =
        tags[event.index].copyWith(isSelected: event.isSelected);
    emit(state.copyWith(tags: [...tags]));
  }

  Future<void> _onTagsAll(TagsAllEvent event, Emitter<HomeState> emit) async {
    final result = await repository.getTags(
      queryParameters: {},
    );
    result.fold(
      (l) {},
      (r) {
        emit(state.copyWith(tags: r));
      },
    );
  }

  Future<void> _onShipper(
    ShipperEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (database.hasAddressDelivery) {
      return;
    }
    final result = await repository.getShipper(shipperId: Constants.shipperId);
    await result.fold(
      (l) {},
      (r) async {
        await localSource.setDeliveryTime(
          int.tryParse(r.maxDeliveryTime ?? "0") ?? 60,
        );
      },
    );
  }

  Future<void> _onBanners(
    BannersEvent event,
    Emitter<HomeState> emit,
  ) async {
    final result = await repository.getBanners();
    result.fold(
      (l) {},
      (r) {
        emit(state.copyWith(banners: r));
      },
    );
  }

  Future<void> _onCategoriesWithProduct(
    CategoriesWithProductEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await repository.getCategoriesWithProduct(
      queryParameters: {
        "page": 1,
        "limit": 1000,
        "all": true,
        "with_discounts": true,
        "only_delivery": true,
        "only_self_pickup": false,
        "order_source": Platform.isIOS ? "ios" : "android",
      },
    );
    await result.fold(
      (Failure l) {
        emit(state.copyWith(isLoading: false));
      },
      (r) async {
        final List<CategoryEntity> list = [];
        for (final element in r) {
          if (element.products.isNotEmpty) {
            list.add(element);
          } else if (element.childCategories.isNotEmpty) {
            final resultCategories = await repository.getCategoryById(
              categoryId: element.id ?? "",
              queryParameters: {},
            );
            resultCategories.fold(
              (l) {},
              (r) {
                if (r.products.isNotEmpty) {
                  list.add(r);
                }
              },
            );
          }
        }
        emit(state.copyWith(categories: list, isLoading: false));
      },
    );
  }
}
