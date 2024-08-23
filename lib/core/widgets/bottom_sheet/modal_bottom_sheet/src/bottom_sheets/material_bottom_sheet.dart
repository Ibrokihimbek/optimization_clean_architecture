part of "package:currency_clean_architecture/core/widgets/bottom_sheet/modal_bottom_sheet/modal_bottom_sheet.dart";

class ShowDragIndicator extends StatelessWidget {
  const ShowDragIndicator({super.key});

  @override
  Widget build(BuildContext context) => Align(
        child: Container(
          height: 4,
          width: 48,
          margin: AppUtils.kPaddingAll16,
          decoration: BoxDecoration(
            color: context.theme.bottomSheetTheme.dragHandleColor,
            borderRadius: AppUtils.kBorderRadius8,
          ),
        ),
      );
}

/// Shows a modal material design bottom sheet.
Future<T?> showMaterialModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior = Clip.antiAlias,
  Color? barrierColor,
  bool bounce = false,
  bool expand = false,
  AnimationController? secondAnimation,
  Curve? animationCurve,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  Duration? duration,
  RouteSettings? settings,
  double? closeProgressThreshold,
}) async {
  assert(debugCheckHasMediaQuery(context), "");
  assert(debugCheckHasMaterialLocalizations(context), "");
  final T? result =
      await Navigator.of(context, rootNavigator: useRootNavigator).push(
    ModalSheetRoute<T>(
      builder: builder,
      closeProgressThreshold: closeProgressThreshold,
      containerBuilder: _materialContainerBuilder(
        context,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: Theme.of(context).bottomSheetTheme.shape,
        clipBehavior: clipBehavior,
        theme: Theme.of(context),
      ),
      secondAnimationController: secondAnimation,
      bounce: bounce,
      expanded: expand,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      isDismissible: isDismissible,
      modalBarrierColor: barrierColor,
      enableDrag: enableDrag,
      animationCurve: animationCurve,
      duration: duration,
      settings: settings,
    ),
  );
  return result;
}

//Default container builder is the Material Appearance
WidgetWithChildBuilder _materialContainerBuilder(
  BuildContext context, {
  Color? backgroundColor,
  double? elevation,
  ThemeData? theme,
  Clip? clipBehavior,
  ShapeBorder? shape,
}) {
  final BottomSheetThemeData bottomSheetTheme =
      Theme.of(context).bottomSheetTheme;
  final Color? color = backgroundColor ??
      bottomSheetTheme.modalBackgroundColor ??
      bottomSheetTheme.backgroundColor;
  final double effectiveElevation =
      elevation ?? bottomSheetTheme.elevation ?? 0.0;
  final ShapeBorder? effectiveShape = shape ?? bottomSheetTheme.shape;
  final Clip effectiveClipBehavior =
      clipBehavior ?? bottomSheetTheme.clipBehavior ?? Clip.none;

  Widget result(_, Animation<dynamic> anim, Widget child) => Material(
        color: color,
        elevation: effectiveElevation,
        shape: effectiveShape,
        clipBehavior: effectiveClipBehavior,
        child: child,
      );
  if (theme != null) {
    return (BuildContext context, Animation<dynamic> animation, Widget child) =>
        Theme(
          data: theme,
          child: result(context, animation, child),
        );
  } else {
    return result;
  }
}
