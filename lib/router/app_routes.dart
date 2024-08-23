import "package:chuck_interceptor/chuck.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:pizza_hut_client_mobile/features/auth/presentation/bloc/confirm/confirm_code_bloc.dart";
import "package:pizza_hut_client_mobile/features/auth/presentation/bloc/login/auth_bloc.dart";
import "package:pizza_hut_client_mobile/features/auth/presentation/bloc/register/register_bloc.dart";
import "package:pizza_hut_client_mobile/features/auth/presentation/pages/auth/auth_page.dart";
import "package:pizza_hut_client_mobile/features/auth/presentation/pages/confirm/argument/confirm_code_argument.dart";
import "package:pizza_hut_client_mobile/features/auth/presentation/pages/confirm/confirm_code_page.dart";
import "package:pizza_hut_client_mobile/features/auth/presentation/pages/register/args/register_argument.dart";
import "package:pizza_hut_client_mobile/features/auth/presentation/pages/register/register_page.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/basket/basket_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/checkout/checkout_order_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/delivery_address/delivery_address_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/home/home_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/notification/notification_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/notification_detail/notification_detail_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/product/product_detail_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/product_review/product_review_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/bloc/user_addresses/user_addresses_bloc.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/pages/basket/basket_page.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/pages/checkout_order/checkout_order_page.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/pages/delivery_address/delivery_address_page.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/pages/home_page.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/pages/notification/notification_detail/notification_detail_page.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/pages/notification/notification_page.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/pages/product/product_detail_page.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/pages/reviews/reviews_page.dart";
import "package:pizza_hut_client_mobile/features/home/presentation/pages/search/search_page.dart";
import "package:pizza_hut_client_mobile/features/main/presentation/bloc/main_bloc.dart";
import "package:pizza_hut_client_mobile/features/main/presentation/pages/main_page.dart";
import "package:pizza_hut_client_mobile/features/orders/presentation/bloc/current_order_detail/current_order_detail_bloc.dart";
import "package:pizza_hut_client_mobile/features/orders/presentation/bloc/history_order_detail/history_order_detail_bloc.dart";
import "package:pizza_hut_client_mobile/features/orders/presentation/bloc/orders/orders_bloc.dart";
import "package:pizza_hut_client_mobile/features/orders/presentation/pages/current_order_detail/current_order_detail.dart";
import "package:pizza_hut_client_mobile/features/orders/presentation/pages/history_order_detail/history_order_detail.dart";
import "package:pizza_hut_client_mobile/features/orders/presentation/pages/orders_page.dart";
import "package:pizza_hut_client_mobile/features/others/presentation/pages/choose_language/choose_langauge_page.dart";
import "package:pizza_hut_client_mobile/features/others/presentation/pages/internet_connection/internet_connection_page.dart";
import "package:pizza_hut_client_mobile/features/others/presentation/pages/splash/splash_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/branches/branches_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/gallery/gallery_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/my_address/my_address_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/news/news_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/profile/delete_account/delete_account_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/profile/edit/profile_edit_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/profile/profile_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/promos/promos_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/recipes/detail/recipe_detail_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/recipes/recipes_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/bloc/vacancies/vacancies_bloc.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/gallery/detail/gallery_detail_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/gallery/gallery_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/my_address/my_address_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/news/detail/news_detail_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/news/news_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/profile_edit/account_management/account_management_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/profile_edit/profile_edit_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/profile_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/promos/detail/promos_detail_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/promos/promos_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/qrcode/qrcode_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/recipes/detail/recipes_detail_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/recipes/recipes_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/restaurants/detail/restaurant_detail_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/restaurants/restaurants_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/settings/privacy_policy/privacy_policy_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/settings/public_offer/public_offer_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/settings/settings_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/support/support_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/vacancies/detail/vacancies_detail_page.dart";
import "package:pizza_hut_client_mobile/features/profile/presentation/pages/vacancies/vacancies_page.dart";
import "package:pizza_hut_client_mobile/injector_container.dart";

part "name_routes.dart";

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> profileKey = GlobalKey<NavigatorState>();

final Chuck chuck = Chuck(navigatorKey: rootNavigatorKey);

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.initial,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.initial,
      name: Routes.initial,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const SplashPage(),
    ),
    GoRoute(
      path: Routes.chooseLanguage,
      name: Routes.chooseLanguage,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const ChooseLanguagePage(),
    ),
    GoRoute(
      path: Routes.noInternet,
      name: Routes.noInternet,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const InternetConnectionPage(),
    ),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (
        _,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) =>
          CustomTransitionPage<void>(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 400),
        child: MultiBlocProvider(
          providers: <BlocProvider<BlocBase<Object?>>>[
            BlocProvider<MainBloc>(
              create: (_) => sl<MainBloc>()..add(const MainAppVersionCheck()),
            ),
            BlocProvider<ProfileBloc>(
              create: (_) => sl<ProfileBloc>()
                ..add(const ProfileCustomerEvent())
                ..add(const ProfileCustomerInfoEvent()),
            ),
            BlocProvider<HomeBloc>(
              create: (_) => sl<HomeBloc>()
                ..add(const BannersEvent())
                ..add(const TagsAllEvent())
                ..add(const ShipperEvent())
                ..add(const CategoriesWithProductEvent()),
            ),
            BlocProvider<OrdersBloc>(
              create: (_) => sl<OrdersBloc>()..add(const CurrentOrdersFetch()),
            ),
            BlocProvider<UserAddressesBloc>(
              create: (_) => sl<UserAddressesBloc>()
                ..add(HomeAddressEvent(onSuccess: () {})),
            ),
          ],
          child: MainPage(navigationShell: navigationShell),
        ),
        transitionsBuilder:
            (_, Animation<double> animation, __, Widget child) =>
                FadeTransition(opacity: animation, child: child),
      ),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          initialLocation: Routes.home,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.home,
              name: Routes.home,
              builder: (_, GoRouterState state) => HomePage(
                key: ObjectKey(state.hashCode),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: Routes.orders,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.orders,
              name: Routes.orders,
              builder: (_, GoRouterState state) => OrdersPage(
                key: ObjectKey(state.hashCode),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: profileKey,
          initialLocation: Routes.profile,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.profile,
              name: Routes.profile,
              parentNavigatorKey: profileKey,
              builder: (_, __) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),

    /// home features
    GoRoute(
      path: Routes.search,
      name: Routes.search,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const SearchPage(),
    ),
    GoRoute(
      path: Routes.deliveryAddress,
      name: Routes.deliveryAddress,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, GoRouterState state) {
        final DeliveryAddressArgument arg =
            state.extra! as DeliveryAddressArgument;
        return BlocProvider<DeliveryAddressBloc>(
          create: (_) => sl<DeliveryAddressBloc>()
            ..add(DeliveryTypeFetch(arg.deliveryType)),
          child: DeliveryAddressPage(argument: arg),
        );
      },
    ),
    GoRoute(
      path: Routes.product,
      name: Routes.product,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, GoRouterState state) {
        final ProductDetailArgument args =
            state.extra! as ProductDetailArgument;
        return BlocProvider<ProductDetailBloc>(
          create: (_) => sl<ProductDetailBloc>()
            ..add(ProductDetailEventInit(args.product))
            ..add(ProductByIdGetEvent(productId: args.product.id ?? ""))
            ..add(FetchReviewsCountEvent(productId: args.product.id ?? "")),
          child: ProductDetailPage(argument: args),
        );
      },
    ),
    GoRoute(
      path: Routes.reviews,
      name: Routes.reviews,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, GoRouterState state) => BlocProvider<ProductReviewBloc>(
        create: (_) => sl<ProductReviewBloc>()
          ..add(
            FetchProductReviewsEvent(productId: state.extra! as String),
          ),
        child: ReviewsPage(
          productId: state.extra! as String,
        ),
      ),
    ),
    GoRoute(
      path: Routes.basket,
      name: Routes.basket,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, GoRouterState state) => BlocProvider<BasketBloc>(
        create: (_) => sl<BasketBloc>()
          ..add(const AutoAddProductFetch())
          ..add(const FetchFavoriteProductEvent()),
        child: const BasketPage(),
      ),
    ),
    GoRoute(
      path: Routes.checkoutOrder,
      name: Routes.checkoutOrder,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, GoRouterState state) => BlocProvider<CheckoutOrderBloc>(
        create: (_) => sl<CheckoutOrderBloc>()
          ..add(const CheckoutInitialEvent())
          ..add(const SourceSettingsFetch())
          ..add(const SavingsCardFetch()),
        child: const CheckoutOrderPage(),
      ),
    ),
    GoRoute(
      path: Routes.notification,
      name: Routes.notification,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => BlocProvider<NotificationBloc>(
        create: (_) => sl<NotificationBloc>()
          ..add(
            const FetchNotificationEvent(),
          ),
        child: const NotificationPage(),
      ),
    ),
    GoRoute(
      path: Routes.notificationDetail,
      name: Routes.notificationDetail,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, GoRouterState state) => BlocProvider<NotificationDetailBloc>(
        create: (_) => sl<NotificationDetailBloc>()
          ..add(
            FetchNotificationDetailEvent(
              notificationId: state.extra! as String,
            ),
          ),
        child: const NotificationDetailPage(),
      ),
    ),
    // GoRoute(
    //   path: Routes.scanner,
    //   name: Routes.scanner,
    //   parentNavigatorKey: rootNavigatorKey,
    //   builder: (_, GoRouterState state) => const ScannerPage(),
    // ),

    /// Orders features

    GoRoute(
      path: Routes.currentOrderDetail,
      name: Routes.currentOrderDetail,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, GoRouterState state) => BlocProvider<CurrentOrderDetailBloc>(
        create: (_) => sl<CurrentOrderDetailBloc>()
          ..add(
            GetOrderDetailEvent(
              orderId: state.extra! is OrderDetailArguments
                  ? (state.extra! as OrderDetailArguments).orderId
                  : state.extra! as String,
              isShowLoading: true,
            ),
          ),
        child: CurrentOrderDetailPage(
          args: state.extra! as OrderDetailArguments,
        ),
      ),
    ),

    GoRoute(
      path: Routes.historyOrderDetail,
      name: Routes.historyOrderDetail,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, GoRouterState state) => BlocProvider<HistoryOrderDetailBloc>(
        create: (_) => sl<HistoryOrderDetailBloc>()
          ..add(
            FetchOrderDetailEvent(
              orderId: state.extra! as String,
            ),
          ),
        child: HistoryOrderDetailPage(
          orderId: state.extra! as String,
        ),
      ),
    ),

    /// profile features
    GoRoute(
      path: Routes.profileEdit,
      name: Routes.profileEdit,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => BlocProvider<ProfileEditBloc>(
        create: (_) => sl<ProfileEditBloc>(),
        child: const ProfileEditPage(),
      ),
    ),
    GoRoute(
      path: Routes.settings,
      name: Routes.settings,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const SettingsPage(),
    ),
    GoRoute(
      path: Routes.promos,
      name: Routes.promos,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => BlocProvider<PromosBloc>(
        create: (_) => sl<PromosBloc>()..add(const PromosGetAllEvent()),
        child: const PromosPage(),
      ),
    ),
    GoRoute(
      path: Routes.promosDetail,
      name: Routes.promosDetail,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, GoRouterState state) {
        final PromosDetailArguments args =
            state.extra! as PromosDetailArguments;
        return PromosDetailPage(args: args);
      },
    ),
    GoRoute(
      path: Routes.vacancies,
      name: Routes.vacancies,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => BlocProvider<VacanciesBloc>(
        create: (_) => sl<VacanciesBloc>()..add(const VacanciesGetAllEvent()),
        child: const VacanciesPage(),
      ),
    ),
    GoRoute(
      path: Routes.vacancyDetail,
      name: Routes.vacancyDetail,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, GoRouterState state) => VacanciesDetailPage(
        args: state.extra! as VacanciesDetailArguments,
      ),
    ),
    GoRoute(
      path: Routes.restaurants,
      name: Routes.restaurants,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => BlocProvider<BranchesBloc>(
        create: (_) => sl<BranchesBloc>()..add(const BranchesGetAllEvent()),
        child: const RestaurantsPage(),
      ),
    ),
    GoRoute(
      path: Routes.restaurantDetail,
      name: Routes.restaurantDetail,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, GoRouterState state) => RestaurantDetailPage(
        args: state.extra! as RestaurantDetailArgument,
      ),
    ),
    GoRoute(
      path: Routes.news,
      name: Routes.news,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => BlocProvider<NewsBloc>(
        create: (_) => sl<NewsBloc>()..add(const NewsGetAllEvent()),
        child: const NewsPage(),
      ),
    ),
    GoRoute(
      path: Routes.newsDetail,
      name: Routes.newsDetail,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, GoRouterState state) {
        final NewsDetailArguments args = state.extra! as NewsDetailArguments;
        return NewsDetailPage(args: args);
      },
    ),
    GoRoute(
      path: Routes.gallery,
      name: Routes.gallery,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => BlocProvider<GalleryBloc>(
        create: (_) => sl<GalleryBloc>()..add(const GalleryGetAllEvent()),
        child: const GalleryPage(),
      ),
    ),
    GoRoute(
      path: Routes.galleryDetail,
      name: Routes.galleryDetail,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, GoRouterState state) => GalleryDetailPage(
        args: state.extra! as GalleryDetailArgument,
      ),
    ),
    GoRoute(
      path: Routes.recipes,
      name: Routes.recipes,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => BlocProvider<RecipesBloc>(
        create: (_) => sl<RecipesBloc>()..add(const RecipesGetAllEvent()),
        child: const RecipesPage(),
      ),
    ),
    GoRoute(
      path: Routes.recipeDetail,
      name: Routes.recipeDetail,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, GoRouterState state) {
        final RecipeDetailArgument arg = state.extra! as RecipeDetailArgument;
        return BlocProvider<RecipeDetailBloc>(
          create: (_) => sl<RecipeDetailBloc>()
            ..add(RecipeGetByEvent(arg))
            ..add(RecipeReviewsCountEvent(arg.recipe.id ?? "")),
          child: RecipesDetailPage(arg: arg),
        );
      },
    ),
    GoRoute(
      path: Routes.qrcode,
      name: Routes.qrcode,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const QrcodePage(),
    ),
    GoRoute(
      path: Routes.support,
      name: Routes.support,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const SupportPage(),
    ),
    GoRoute(
      path: Routes.accountManagement,
      name: Routes.accountManagement,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => BlocProvider<DeleteAccountBloc>(
        create: (_) => sl<DeleteAccountBloc>(),
        child: const AccountManagementPage(),
      ),
    ),
    GoRoute(
      path: Routes.privacyPolicy,
      name: Routes.privacyPolicy,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const PrivacyPolicyPage(),
    ),
    GoRoute(
      path: Routes.publicOffer,
      name: Routes.publicOffer,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const PublicOfferPage(),
    ),
    GoRoute(
      path: Routes.myAddress,
      name: Routes.myAddress,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => BlocProvider<MyAddressBloc>(
        create: (_) => sl<MyAddressBloc>(),
        child: const MyAddressPage(),
      ),
    ),

    /// auth
    GoRoute(
      path: Routes.auth,
      name: Routes.auth,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => BlocProvider<AuthBloc>(
        create: (_) => sl<AuthBloc>(),
        child: const AuthPage(),
      ),
    ),
    GoRoute(
      path: Routes.confirmCode,
      name: Routes.confirmCode,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, GoRouterState state) => BlocProvider<ConfirmCodeBloc>(
        create: (_) => sl<ConfirmCodeBloc>(),
        child: ConfirmCodePage(args: state.extra! as ConfirmCodeArgument),
      ),
    ),
    GoRoute(
      path: Routes.register,
      name: Routes.register,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, GoRouterState state) => BlocProvider<RegisterBloc>(
        create: (_) => sl<RegisterBloc>(),
        child: RegisterPage(args: state.extra! as RegisterArgument),
      ),
    ),
  ],
);
