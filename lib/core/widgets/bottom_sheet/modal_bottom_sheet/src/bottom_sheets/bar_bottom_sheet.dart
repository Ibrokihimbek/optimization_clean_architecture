part of "package:currency_clean_architecture/core/widgets/bottom_sheet/modal_bottom_sheet/modal_bottom_sheet.dart";

const Radius kDefaultBarTopRadius = Radius.circular(15);

class BarBottomSheet extends StatelessWidget {
  const BarBottomSheet({
    super.key,
    required this.child,
    this.control,
    this.clipBehavior,
    this.shape,
    this.backgroundColor,
    this.elevation,
    this.overlayStyle,
  });

  final Widget child;
  final Widget? control;
  final Clip? clipBehavior;
  final Color? backgroundColor;
  final double? elevation;
  final ShapeBorder? shape;
  final SystemUiOverlayStyle? overlayStyle;

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle ?? SystemUiOverlayStyle.light,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 12),
            SafeArea(
              bottom: false,
              child: control ??
                  Container(
                    height: 6,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Material(
                shape: shape ??
                    const RoundedRectangleBorder(
                      side: BorderSide(),
                      borderRadius: BorderRadius.only(
                        topLeft: kDefaultBarTopRadius,
                        topRight: kDefaultBarTopRadius,
                      ),
                    ),
                clipBehavior: clipBehavior ?? Clip.hardEdge,
                color: backgroundColor ?? Colors.white,
                elevation: elevation ?? 2,
                child: SizedBox(
                  width: double.infinity,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

Future<T?> showBarModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  Color barrierColor = Colors.black87,
  bool bounce = true,
  bool expand = false,
  AnimationController? secondAnimation,
  Curve? animationCurve,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  Widget? topControl,
  Duration? duration,
  RouteSettings? settings,
  SystemUiOverlayStyle? overlayStyle,
  double? closeProgressThreshold,
}) async {
  assert(debugCheckHasMediaQuery(context), "");
  assert(debugCheckHasMaterialLocalizations(context), "");
  final T? result =
      await Navigator.of(context, rootNavigator: useRootNavigator).push(
    ModalSheetRoute<T>(
      builder: builder,
      bounce: bounce,
      closeProgressThreshold: closeProgressThreshold,
      containerBuilder: (_, __, Widget child) => BarBottomSheet(
        control: topControl,
        clipBehavior: clipBehavior,
        shape: shape,
        backgroundColor: backgroundColor,
        elevation: elevation,
        overlayStyle: overlayStyle,
        child: child,
      ),
      secondAnimationController: secondAnimation,
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
