part of "package:pizza_hut_client_mobile/core/widgets/bottom_sheet/modal_bottom_sheet/modal_bottom_sheet.dart";

typedef StatusBarGestureDetectorCallback = void Function(BuildContext context);

class StatusBarGestureDetector extends StatefulWidget {
  const StatusBarGestureDetector({
    super.key,
    required this.child,
    required this.onTap,
  });

  final Widget child;

  final StatusBarGestureDetectorCallback onTap;

  @override
  State<StatusBarGestureDetector> createState() =>
      _StatusBarGestureDetectorState();
}

class _StatusBarGestureDetectorState extends State<StatusBarGestureDetector> {
  final OverlayPortalController controller = OverlayPortalController();

  @override
  void initState() {
    controller.show();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FlutterView view = View.of(context);
    return OverlayPortal.targetsRootOverlay(
      controller: controller,
      overlayChildBuilder: (BuildContext context) => Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: view.padding.top / view.devicePixelRatio,
          width: double.infinity,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => widget.onTap(context),
            // iOS accessibility automatically adds scroll-to-top to the clock in the status bar
            excludeFromSemantics: true,
          ),
        ),
      ),
      child: widget.child,
    );
  }
}
