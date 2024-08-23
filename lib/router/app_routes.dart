import "package:chuck_interceptor/chuck.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:currency_clean_architecture/features/home/presentation/bloc/home/home_bloc.dart";
import "package:currency_clean_architecture/features/home/presentation/pages/home_page.dart";
import "package:currency_clean_architecture/features/main/presentation/bloc/main_bloc.dart";
import "package:currency_clean_architecture/features/main/presentation/pages/main_page.dart";
import "package:currency_clean_architecture/features/orders/presentation/pages/orders_page.dart";
import "package:currency_clean_architecture/features/others/presentation/pages/choose_language/choose_langauge_page.dart";
import "package:currency_clean_architecture/features/others/presentation/pages/internet_connection/internet_connection_page.dart";
import "package:currency_clean_architecture/features/others/presentation/pages/splash/splash_page.dart";
import "package:currency_clean_architecture/injector_container.dart";

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
              create: (_) => sl<MainBloc>(),
            ),
            BlocProvider<HomeBloc>(
              create: (_) => sl<HomeBloc>()..add(const FetchCurrencyEvent()),
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
              builder: (_, GoRouterState state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: Routes.profile,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.profile,
              name: Routes.profile,
              builder: (_, GoRouterState state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
