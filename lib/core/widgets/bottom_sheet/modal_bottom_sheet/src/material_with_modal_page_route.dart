part of "package:currency_clean_architecture/core/widgets/bottom_sheet/modal_bottom_sheet/modal_bottom_sheet.dart";

class MaterialWithModalsPageRoute<T> extends MaterialPageRoute<T> {
  MaterialWithModalsPageRoute({
    required super.builder,
    super.settings,
    super.maintainState,
    super.fullscreenDialog,
  });

  ModalSheetRoute<dynamic>? _nextModalRoute;

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) =>
      (nextRoute is MaterialPageRoute && !nextRoute.fullscreenDialog) ||
      (nextRoute is CupertinoPageRoute && !nextRoute.fullscreenDialog) ||
      (nextRoute is MaterialWithModalsPageRoute &&
          !nextRoute.fullscreenDialog) ||
      (nextRoute is ModalSheetRoute);

  @override
  void didChangeNext(Route<dynamic>? nextRoute) {
    if (nextRoute is ModalSheetRoute) {
      _nextModalRoute = nextRoute;
    }

    super.didChangeNext(nextRoute);
  }

  @override
  bool didPop(T? result) {
    _nextModalRoute = null;
    return super.didPop(result);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
    final ModalSheetRoute<dynamic>? nextRoute = _nextModalRoute;
    if (nextRoute != null) {
      if (!secondaryAnimation.isDismissed) {
        // Avoid default transition theme to animate when a new modal view is pushed
        final Animation<double> fakeSecondaryAnimation =
            Tween<double>(begin: 0, end: 0).animate(secondaryAnimation);

        final Widget defaultTransition = theme.buildTransitions<T>(
          this,
          context,
          animation,
          fakeSecondaryAnimation,
          child,
        );
        return nextRoute.getPreviousRouteTransition(
          context,
          secondaryAnimation,
          defaultTransition,
        );
      } else {
        _nextModalRoute = null;
      }
    }

    return theme.buildTransitions<T>(
      this,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
