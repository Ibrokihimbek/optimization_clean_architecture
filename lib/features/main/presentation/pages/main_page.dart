// ignore_for_file: discarded_futures

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:pizza_hut_client_mobile/core/extension/extension.dart";
import "package:pizza_hut_client_mobile/core/theme/themes.dart";
import "package:pizza_hut_client_mobile/features/main/presentation/bloc/main_bloc.dart";
import "package:pizza_hut_client_mobile/features/main/presentation/pages/mixin/main_mixin.dart";
import "package:pizza_hut_client_mobile/injector_container.dart";
import "package:pizza_hut_client_mobile/router/app_routes.dart";

class MainPage extends StatelessWidget with MainMixin {
  const MainPage({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => BlocListener<MainBloc, MainState>(
        listenWhen: (MainState p, MainState c) => p.status != c.status,
        listener: onListener,
        child: PopScope(
          canPop: navigationShell.currentIndex != 0,
          onPopInvokedWithResult: (bool v, _) => navigationShell.goBranch(0),
          child: Scaffold(
            body: navigationShell,
            bottomNavigationBar: DecoratedBox(
              decoration: context.gradients.shadowDecoration,
              child: BottomNavigationBar(
                currentIndex: navigationShell.currentIndex,
                onTap: (int index) => changeTap(index, context),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: const Icon(AppIcons.home),
                    activeIcon: const Icon(AppIcons.home_active),
                    label: context.tr("home"),
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(AppIcons.chat_info),
                    activeIcon: const Icon(AppIcons.receipt),
                    label: context.tr("orders"),
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(AppIcons.account_circle),
                    activeIcon: const Icon(AppIcons.profile_circle),
                    label: context.tr("profile"),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void changeTap(
    int index,
    BuildContext context,
  ) {
    if ((index == 2 || index == 1) && !localSource.hasProfile) {
      context.pushNamed(Routes.auth);
      return;
    }
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
