part of "package:pizza_hut_client_mobile/core/widgets/bottom_sheet/modal_bottom_sheet/modal_bottom_sheet.dart";

const double _kPreviousPageVisibleOffset = 10;

const Radius _kDefaultTopRadius = Radius.circular(12);
const BoxShadow _kDefaultBoxShadow =
    BoxShadow(blurRadius: 10, color: Colors.black12, spreadRadius: 5);

SystemUiOverlayStyle overlayStyleFromColor(Color color) {
  final Brightness brightness = ThemeData.estimateBrightnessForColor(color);
  return brightness == Brightness.dark
      ? SystemUiOverlayStyle.light
      : SystemUiOverlayStyle.dark;
}

/// Cupertino Bottom Sheet Container
///
/// Clip the child widget to rectangle with top rounded corners and adds
/// top padding(+safe area padding). This padding [_kPreviousPageVisibleOffset]
/// is the height that will be displayed from previous route.
class _CupertinoBottomSheetContainer extends StatelessWidget {
  const _CupertinoBottomSheetContainer({
    required this.child,
    this.backgroundColor,
    required this.topRadius,
    this.overlayStyle,
    this.shadow,
  });

  final Widget child;
  final Color? backgroundColor;
  final Radius topRadius;
  final BoxShadow? shadow;
  final SystemUiOverlayStyle? overlayStyle;

  @override
  Widget build(BuildContext context) {
    final SystemUiOverlayStyle? scopedOverlayStyle = overlayStyle;
    final double topSafeAreaPadding = MediaQuery.of(context).padding.top;
    final double topPadding = _kPreviousPageVisibleOffset + topSafeAreaPadding;

    final BoxShadow shadow = this.shadow ?? _kDefaultBoxShadow;
    const BoxShadow(blurRadius: 10, color: Colors.black12, spreadRadius: 5);
    final Color backgroundColor = this.backgroundColor ??
        CupertinoTheme.of(context).scaffoldBackgroundColor;
    Widget bottomSheetContainer = Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: topRadius),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: <BoxShadow>[shadow],
          ),
          width: double.infinity,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true, //Remove top Safe Area
            child: CupertinoUserInterfaceLevel(
              data: CupertinoUserInterfaceLevelData.elevated,
              child: child,
            ),
          ),
        ),
      ),
    );
    if (scopedOverlayStyle != null) {
      bottomSheetContainer = AnnotatedRegion<SystemUiOverlayStyle>(
        value: scopedOverlayStyle,
        child: bottomSheetContainer,
      );
    }
    return bottomSheetContainer;
  }
}

Future<T?> showCupertinoModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  Color? barrierColor,
  bool expand = false,
  AnimationController? secondAnimation,
  Curve? animationCurve,
  Curve? previousRouteAnimationCurve,
  bool useRootNavigator = false,
  bool bounce = true,
  bool? isDismissible,
  bool enableDrag = true,
  Radius topRadius = _kDefaultTopRadius,
  Duration? duration,
  RouteSettings? settings,
  Color? transitionBackgroundColor,
  BoxShadow? shadow,
  SystemUiOverlayStyle? overlayStyle,
  double? closeProgressThreshold,
}) async {
  assert(debugCheckHasMediaQuery(context), "");
  final bool hasMaterialLocalizations =
      Localizations.of<MaterialLocalizations>(context, MaterialLocalizations) !=
          null;
  final String barrierLabel = hasMaterialLocalizations
      ? MaterialLocalizations.of(context).modalBarrierDismissLabel
      : "";
  final T? result =
      await Navigator.of(context, rootNavigator: useRootNavigator).push(
    CupertinoModalBottomSheetRoute<T>(
      builder: builder,
      containerBuilder: (BuildContext context, _, Widget child) =>
          _CupertinoBottomSheetContainer(
        backgroundColor: backgroundColor,
        topRadius: topRadius,
        shadow: shadow,
        overlayStyle: overlayStyle,
        child: child,
      ),
      secondAnimationController: secondAnimation,
      expanded: expand,
      closeProgressThreshold: closeProgressThreshold,
      barrierLabel: barrierLabel,
      bounce: bounce,
      isDismissible: isDismissible ?? !expand,
      modalBarrierColor: barrierColor ?? Colors.black12,
      enableDrag: enableDrag,
      topRadius: topRadius,
      animationCurve: animationCurve,
      previousRouteAnimationCurve: previousRouteAnimationCurve,
      duration: duration,
      settings: settings,
      transitionBackgroundColor: transitionBackgroundColor ?? Colors.black,
    ),
  );
  return result;
}

class CupertinoModalBottomSheetRoute<T> extends ModalSheetRoute<T> {
  CupertinoModalBottomSheetRoute({
    required super.builder,
    super.containerBuilder,
    super.closeProgressThreshold,
    super.barrierLabel,
    super.secondAnimationController,
    super.animationCurve,
    super.modalBarrierColor,
    super.bounce = true,
    super.isDismissible,
    super.enableDrag,
    required super.expanded,
    super.duration,
    super.settings,
    super.scrollController,
    this.boxShadow = _kDefaultBoxShadow,
    this.transitionBackgroundColor,
    this.topRadius = _kDefaultTopRadius,
    this.previousRouteAnimationCurve,
  });

  final Radius topRadius;

  final Curve? previousRouteAnimationCurve;

  final BoxShadow? boxShadow;

  // Background color behind all routes
  // Black by default
  final Color? transitionBackgroundColor;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final double paddingTop = MediaQuery.of(context).padding.top;
    final double distanceWithScale =
        (paddingTop + _kPreviousPageVisibleOffset) * 0.9;
    final double offsetY =
        secondaryAnimation.value * (paddingTop - distanceWithScale);
    final double scale = 1 - secondaryAnimation.value / 10;
    return AnimatedBuilder(
      builder: (BuildContext context, Widget? child) => Transform.translate(
        offset: Offset(0, offsetY),
        child: Transform.scale(
          scale: scale,
          alignment: Alignment.topCenter,
          child: child,
        ),
      ),
      animation: secondaryAnimation,
      child: child,
    );
  }

  @override
  Widget getPreviousRouteTransition(
    BuildContext context,
    Animation<double> secondAnimation,
    Widget child,
  ) =>
      _CupertinoModalTransition(
        secondaryAnimation: secondAnimation,
        body: child,
        animationCurve: previousRouteAnimationCurve,
        topRadius: topRadius,
        backgroundColor: transitionBackgroundColor ?? Colors.black,
      );
}

class _CupertinoModalTransition extends StatelessWidget {
  const _CupertinoModalTransition({
    required this.secondaryAnimation,
    required this.body,
    required this.topRadius,
    this.backgroundColor = Colors.black,
    this.animationCurve,
  });

  final Animation<double> secondaryAnimation;
  final Radius topRadius;
  final Curve? animationCurve;
  final Color backgroundColor;

  final Widget body;

  @override
  Widget build(BuildContext context) {
    double startRoundCorner = 0;
    final double paddingTop = MediaQuery.of(context).padding.top;
    if (Theme.of(context).platform == TargetPlatform.iOS && paddingTop > 20) {
      startRoundCorner = 38.5;
      //https://kylebashour.com/posts/finding-the-real-iphone-x-corner-radius
    }

    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: secondaryAnimation,
      curve: animationCurve ?? Curves.easeOut,
    );

    return AnimatedBuilder(
      animation: curvedAnimation,
      child: body,
      builder: (BuildContext context, Widget? child) {
        final double progress = curvedAnimation.value;
        final double yOffset = progress * paddingTop;
        final double scale = 1 - progress / 10;
        final double radius = progress == 0
            ? 0.0
            : (1 - progress) * startRoundCorner + progress * topRadius.x;
        return Stack(
          children: <Widget>[
            Container(color: backgroundColor),
            Transform.translate(
              offset: Offset(0, yOffset),
              child: Transform.scale(
                scale: scale,
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: CupertinoUserInterfaceLevel(
                    data: CupertinoUserInterfaceLevelData.elevated,
                    child: Builder(
                      builder: (BuildContext context) => CupertinoTheme(
                        data: createPreviousRouteTheme(
                          context,
                          curvedAnimation,
                        ),
                        child: CupertinoUserInterfaceLevel(
                          data: CupertinoUserInterfaceLevelData.base,
                          child: child!,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  CupertinoThemeData createPreviousRouteTheme(
    BuildContext context,
    Animation<double> animation,
  ) {
    final CupertinoThemeData cTheme = CupertinoTheme.of(context);

    final Color systemBackground = CupertinoDynamicColor.resolve(
      cTheme.scaffoldBackgroundColor,
      context,
    );

    final Color barBackgroundColor = CupertinoDynamicColor.resolve(
      cTheme.barBackgroundColor,
      context,
    );

    CupertinoThemeData previousRouteTheme = cTheme;

    if (cTheme.scaffoldBackgroundColor is CupertinoDynamicColor) {
      final CupertinoDynamicColor dynamicScaffoldBackgroundColor =
          cTheme.scaffoldBackgroundColor as CupertinoDynamicColor;

      /// BackgroundColor for the previous route with forced using
      /// of the elevated colors
      final CupertinoDynamicColor elevatedScaffoldBackgroundColor =
          CupertinoDynamicColor.withBrightnessAndContrast(
        color: dynamicScaffoldBackgroundColor.elevatedColor,
        darkColor: dynamicScaffoldBackgroundColor.darkElevatedColor,
        highContrastColor:
            dynamicScaffoldBackgroundColor.highContrastElevatedColor,
        darkHighContrastColor:
            dynamicScaffoldBackgroundColor.darkHighContrastElevatedColor,
      );

      previousRouteTheme = previousRouteTheme.copyWith(
        scaffoldBackgroundColor: ColorTween(
          begin: systemBackground,
          end: elevatedScaffoldBackgroundColor.resolveFrom(context),
        ).evaluate(animation),
        primaryColor: CupertinoColors.placeholderText.resolveFrom(context),
      );
    }

    if (cTheme.barBackgroundColor is CupertinoDynamicColor) {
      final CupertinoDynamicColor dynamicBarBackgroundColor =
          cTheme.barBackgroundColor as CupertinoDynamicColor;

      /// NavigationBarColor for the previous route with forced using
      /// of the elevated colors
      final CupertinoDynamicColor elevatedBarBackgroundColor =
          CupertinoDynamicColor.withBrightnessAndContrast(
        color: dynamicBarBackgroundColor.elevatedColor,
        darkColor: dynamicBarBackgroundColor.darkElevatedColor,
        highContrastColor: dynamicBarBackgroundColor.highContrastElevatedColor,
        darkHighContrastColor:
            dynamicBarBackgroundColor.darkHighContrastElevatedColor,
      );

      previousRouteTheme = previousRouteTheme.copyWith(
        barBackgroundColor: ColorTween(
          begin: barBackgroundColor,
          end: elevatedBarBackgroundColor.resolveFrom(context),
        ).evaluate(animation),
        primaryColor: CupertinoColors.placeholderText.resolveFrom(context),
      );
    }

    return previousRouteTheme;
  }
}

class CupertinoScaffoldInheirted extends InheritedWidget {
  const CupertinoScaffoldInheirted({
    super.key,
    this.animation,
    required super.child,
    this.topRadius,
    required this.transitionBackgroundColor,
  });

  final AnimationController? animation;

  final Radius? topRadius;
  final Color transitionBackgroundColor;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

// Support
class CupertinoScaffold extends StatefulWidget {
  const CupertinoScaffold({
    super.key,
    required this.body,
    this.topRadius = _kDefaultTopRadius,
    this.transitionBackgroundColor = Colors.black,
    this.overlayStyle,
  });

  static CupertinoScaffoldInheirted? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CupertinoScaffoldInheirted>();

  final Widget body;
  final Radius topRadius;
  final Color transitionBackgroundColor;
  final SystemUiOverlayStyle? overlayStyle;

  @override
  State<StatefulWidget> createState() => _CupertinoScaffoldState();

  static Future<T?> showCupertinoModalBottomSheet<T>({
    required BuildContext context,
    double? closeProgressThreshold,
    required WidgetBuilder builder,
    Curve? animationCurve,
    Curve? previousRouteAnimationCurve,
    Color? backgroundColor,
    Color? barrierColor,
    bool expand = false,
    bool useRootNavigator = false,
    bool bounce = true,
    bool? isDismissible,
    bool enableDrag = true,
    Duration? duration,
    RouteSettings? settings,
    BoxShadow? shadow,
    @Deprecated(
      "Will be ignored. OverlayStyle is computed from luminance of transitionBackgroundColor",
    )
    SystemUiOverlayStyle? overlayStyle,
  }) async {
    assert(debugCheckHasMediaQuery(context), "No MediaQuery widget found.");
    final bool isCupertinoApp =
        context.findAncestorWidgetOfExactType<CupertinoApp>() != null;
    String barrierLabel = "";
    if (!isCupertinoApp) {
      assert(debugCheckHasMaterialLocalizations(context), "");
      barrierLabel = MaterialLocalizations.of(context).modalBarrierDismissLabel;
    }
    final Radius? topRadius = CupertinoScaffold.of(context)!.topRadius;
    final Color transitionBackgroundColor =
        CupertinoScaffold.of(context)!.transitionBackgroundColor;
    final SystemUiOverlayStyle overlayStyle =
        overlayStyleFromColor(transitionBackgroundColor);
    final T? result =
        await Navigator.of(context, rootNavigator: useRootNavigator).push(
      CupertinoModalBottomSheetRoute<T>(
        closeProgressThreshold: closeProgressThreshold,
        builder: builder,
        secondAnimationController: CupertinoScaffold.of(context)!.animation,
        containerBuilder: (BuildContext context, _, Widget child) =>
            _CupertinoBottomSheetContainer(
          backgroundColor: backgroundColor,
          topRadius: topRadius ?? _kDefaultTopRadius,
          shadow: shadow,
          overlayStyle: overlayStyle,
          child: child,
        ),
        expanded: expand,
        barrierLabel: barrierLabel,
        bounce: bounce,
        isDismissible: isDismissible ?? !expand,
        modalBarrierColor: barrierColor ?? Colors.black12,
        enableDrag: enableDrag,
        topRadius: topRadius ?? _kDefaultTopRadius,
        animationCurve: animationCurve,
        previousRouteAnimationCurve: previousRouteAnimationCurve,
        duration: duration,
        settings: settings,
      ),
    );
    return result;
  }
}

class _CupertinoScaffoldState extends State<CupertinoScaffold>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => CupertinoScaffoldInheirted(
        animation: animationController,
        topRadius: widget.topRadius,
        transitionBackgroundColor: widget.transitionBackgroundColor,
        child: _CupertinoModalTransition(
          secondaryAnimation: animationController,
          body: widget.body,
          topRadius: widget.topRadius,
          backgroundColor: widget.transitionBackgroundColor,
        ),
      );
}
