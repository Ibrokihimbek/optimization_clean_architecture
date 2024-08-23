// ignore_for_file: always_specify_types

import "package:currency_clean_architecture/core/utils/utils.dart";
import "package:currency_clean_architecture/features/home/data/models/currency_response_model.dart";
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:currency_clean_architecture/features/home/domain/repository/home_repository.dart";

part "home_event.dart";

part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.repository,
  }) : super(const HomeState()){
    on<FetchCurrencyEvent>(_getCurrency);
  }

  final HomeRepository repository;

  Future<void> _getCurrency(
      FetchCurrencyEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    final result = await repository.getCurrency();
    result.fold(
      (failure) {
        emit(state.copyWith(apiStatus: ApiStatus.error));
      },
      (currency) {
        emit(
          state.copyWith(
            currency: currency,
            apiStatus: ApiStatus.success,
          ),
        );
      },
    );
  }
}
