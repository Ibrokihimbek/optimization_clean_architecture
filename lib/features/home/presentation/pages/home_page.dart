// ignore_for_file: discarded_futures, always_specify_types

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:hive/hive.dart";
import "package:pizza_hut_client_mobile/core/extension/extension.dart";
import "package:pizza_hut_client_mobile/core/local_source/hive_database.dart";
import "package:pizza_hut_client_mobile/core/local_source/product_hive.dart";
import "package:pizza_hut_client_mobile/core/theme/themes.dart";
import "package:pizza_hut_client_mobile/core/utils/utils.dart";
import "package:pizza_hut_client_mobile/core/widgets/loading/modal_progress_hud.dart";
import "package:pizza_hut_client_mobile/core/widgets/vertical_scrollable/vertical_scrollable_tabview.dart";

import "package:pizza_hut_client_mobile/features/home/data/models/ondemand_order_request.dart";
import "package:pizza_hut_client_mobile/features/home/domain/entities/category_entity.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/home/home_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/pages/delivery_address/delivery_address_page.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/pages/widgets/banners_widget.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/pages/widgets/cart_button.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/pages/widgets/delivery_type_widget.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/pages/widgets/home_tab_bar.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/pages/widgets/home_title.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/pages/widgets/product_item.dart";
import "package:pizza_hut_client_mobile/injector_container.dart";
import "package:pizza_hut_client_mobile/router/app_routes.dart";
import "package:scroll_to_index/scroll_to_index.dart";

part "mixin/home_mixin.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with HomeMixin, TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => ValueListenableBuilder<Box<dynamic>>(
        valueListenable: database.deliveryAddressBox.listenable(),
        builder: (_, __, ___) => Theme(
          data: context.theme.copyWith(
            bottomSheetTheme: context.theme.bottomSheetTheme.copyWith(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              leadingWidth: 32,
              leading: const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Icon(AppIcons.marker_pin),
              ),
              title: const HomeTitle(),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    context.pushNamed(Routes.notification);
                  },
                  icon: const Icon(AppIcons.notification),
                ),
                IconButton(
                  onPressed: () {
                    context.pushNamed(Routes.search);
                  },
                  icon: const Icon(AppIcons.search),
                ),
              ],
              scrolledUnderElevation: 0,
              bottom: DeliveryTypeWidget(
                deliveryType: deliveryType,
                onChanged: (DeliveryType type) {
                  deliveryType.value = type;
                  if (type.isDelivery && !database.isDelivery) {
                    context.pushNamed(
                      Routes.deliveryAddress,
                      extra: DeliveryAddressArgument(deliveryType: type),
                    );
                  } else if (type.isSelfPickup && !database.isPickUp) {
                    context.pushNamed(
                      Routes.deliveryAddress,
                      extra: DeliveryAddressArgument(deliveryType: type),
                    );
                  }
                },
              ),
            ),
            body: BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (HomeState p, HomeState c) =>
                  p.categories != c.categories ||
                  p.isLoading != c.isLoading ||
                  p.products != c.products,
              builder: (_, HomeState state) {
                if (state.categories.isNotEmpty) {
                  tabController = TabController(
                    length: state.categories.length,
                    vsync: this,
                  );
                }
                return ModalProgressHUD(
                  inAsyncCall: state.isLoading,
                  child: state.categories.isEmpty
                      ? AppUtils.kGap
                      : VerticalScrollableTabView<CategoryEntity>(
                          key: ObjectKey(state.categories.hashCode),
                          cacheExtent: 1000,
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          tabController: tabController,
                          autoScrollController: autoScrollController,
                          listItemData: state.categories,
                          eachItemChild: (category, index) => Column(
                            key: ObjectKey(category.hashCode),
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: AppUtils.kPaddingAll16,
                                child: Text(
                                  category.title?.name ?? "",
                                  style: context.textTheme.headlineLarge,
                                ),
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                padding: AppUtils.kPaddingHor16,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, int index) => ProductItem(
                                  key: ObjectKey(
                                    category.products[index].hashCode,
                                  ),
                                  product: category.products[index],
                                ),
                                separatorBuilder: (_, __) => AppUtils.kGap8,
                                itemCount: category.products.length,
                              ),
                              if (index == state.categories.length - 1)
                                AppUtils.kGap16,
                              if (index == state.categories.length - 1)
                                ValueListenableBuilder<Box<ProductHive>>(
                                  valueListenable:
                                      database.boxProduct.listenable(),
                                  builder: (_, __, ___) => Visibility(
                                    visible: database.products.isNotEmpty,
                                    child: AppUtils.kGap56,
                                  ),
                                ),
                            ],
                          ),
                          slivers: <Widget>[
                            const BannersWidget(),
                            HomeTabBar(
                              onTabChanged: (int index) {
                                autoScrollController.scrollToIndex(
                                  index,
                                  duration: const Duration(milliseconds: 300),
                                  preferPosition: AutoScrollPosition.begin,
                                );
                                VerticalScrollableTabBarStatus.setIndex(index);
                              },
                              selectedTab: selectedTab,
                              tabController: tabController,
                              categories: state.categories,
                            ),
                          ],
                        ),
                );
              },
            ),
            bottomSheet: const CartButton(),
          ),
        ),
      );
}
