// ignore_for_file: discarded_futures

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:currency_clean_architecture/core/extension/extension.dart";
import "package:currency_clean_architecture/core/theme/themes.dart";
import "package:currency_clean_architecture/features/main/presentation/bloc/main_bloc.dart";
import "package:currency_clean_architecture/features/main/presentation/pages/mixin/main_mixin.dart";

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
                    icon: const Icon(Icons.home),
                    activeIcon: Icon(
                      Icons.home,
                      color: context.colorScheme.primary,
                    ),
                    label: context.tr("home"),
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.person),
                    activeIcon: Icon(
                      Icons.person,
                      color: context.colorScheme.primary,
                    ),
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
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
