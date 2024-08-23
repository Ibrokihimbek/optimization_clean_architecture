// ignore_for_file: discarded_futures, avoid_positional_boolean_parameters
part of "package:pizza_hut_client_mobile/core/widgets/bottom_sheet/modal_bottom_sheet/modal_bottom_sheet.dart";

const Curve _decelerateEasing = Cubic(0, 0, 0.2, 1);

const Duration _bottomSheetDuration = Duration(milliseconds: 400);
const double _minFlingVelocity = 500;
const double _closeProgressThreshold = 0.6;
const double _willPopThreshold = 0.8;

typedef WidgetWithChildBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
  Widget child,
);

class ModalBottomSheet extends StatefulWidget {
  /// Creates a bottom sheet.
  const ModalBottomSheet({
    super.key,
    required this.animationController,
    this.animationCurve,
    this.enableDrag = true,
    this.containerBuilder,
    this.bounce = true,
    this.shouldClose,
    required this.scrollController,
    required this.expanded,
    required this.onClosing,
    required this.child,
    this.minFlingVelocity = _minFlingVelocity,
    double? closeProgressThreshold,
    @Deprecated("Use preventPopThreshold instead") double? willPopThreshold,
    double? preventPopThreshold,
  })  : preventPopThreshold =
            preventPopThreshold ?? willPopThreshold ?? _willPopThreshold,
        closeProgressThreshold =
            closeProgressThreshold ?? _closeProgressThreshold;

  /// The closeProgressThreshold parameter
  /// specifies when the bottom sheet will be dismissed when user drags it.
  final double closeProgressThreshold;

  /// The animation controller that controls the bottom sheet's entrance and
  /// exit animations.
  ///
  /// The BottomSheet widget will manipulate the position of this animation, it
  /// is not just a passive observer.
  final AnimationController animationController;

  /// The curve used by the animation showing and dismissing the bottom sheet.
  ///
  /// If no curve is provided it falls back to `decelerateEasing`.
  final Curve? animationCurve;

  /// Allows the bottom sheet to  go beyond the top bound of the content,
  /// but then bounce the content back to the edge of
  /// the top bound.
  final bool bounce;

  // Force the widget to fill the maximum size of the viewport
  // or if false it will fit to the content of the widget
  final bool expanded;

  final WidgetWithChildBuilder? containerBuilder;

  /// Called when the bottom sheet begins to close.
  ///
  /// A bottom sheet might be prevented from closing (e.g., by user
  /// interaction) even after this callback is called. For this reason, this
  /// callback might be call multiple times for a given bottom sheet.
  final void Function() onClosing;

  // If shouldClose is null is ignored.
  // If returns true => The dialog closes
  // If returns false => The dialog cancels close
  // Notice that if shouldClose is not null, the dialog will go back to the
  // previous position until the function is solved
  final Future<bool> Function()? shouldClose;

  /// A builder for the contents of the sheet.
  ///
  final Widget child;

  /// If true, the bottom sheet can be dragged up and down and dismissed by
  /// swiping downwards.
  ///
  /// Default is true.
  final bool enableDrag;

  final ScrollController scrollController;

  /// The minFlingVelocity parameter
  /// Determines how fast the sheet should be flinged before closing.
  final double minFlingVelocity;

  /// The preventPopThreshold parameter
  /// Determines how far the sheet should be flinged before closing.
  final double preventPopThreshold;

  @override
  ModalBottomSheetState createState() => ModalBottomSheetState();

  /// Creates an [AnimationController] suitable for a
  /// [ModalBottomSheet.animationController].
  ///
  /// This API available as a convenience for a Material compliant bottom sheet
  /// animation. If alternative animation durations are required, a different
  /// animation controller could be provided.
  static AnimationController createAnimationController(
    TickerProvider vsync, {
    Duration? duration,
  }) =>
      AnimationController(
        duration: duration ?? _bottomSheetDuration,
        debugLabel: "BottomSheet",
        vsync: vsync,
      );
}

class ModalBottomSheetState extends State<ModalBottomSheet>
    with TickerProviderStateMixin {
  final GlobalKey _childKey = GlobalKey(debugLabel: "BottomSheet child");

  ScrollController get _scrollController => widget.scrollController;

  late AnimationController _bounceDragController;

  double? get _childHeight {
    final BuildContext? childContext = _childKey.currentContext;
    final RenderBox renderBox = childContext!.findRenderObject()! as RenderBox;
    return renderBox.size.height;
  }

  bool get _dismissUnderway =>
      widget.animationController.status == AnimationStatus.reverse;

  // Detect if user is dragging.
  // Used on NotificationListener to detect if ScrollNotifications are
  // before or after the user stop dragging
  bool isDragging = false;

  bool get hasReachedWillPopThreshold =>
      widget.animationController.value < _willPopThreshold;

  bool get hasReachedCloseThreshold =>
      widget.animationController.value < widget.closeProgressThreshold;

  void _close() {
    isDragging = false;
    widget.onClosing();
  }

  void _cancelClose() {
    unawaited(
      widget.animationController.forward().then((_) {
        // When using WillPop, animation doesn't end at 1.
        // Check more in detail the problem
        if (!widget.animationController.isCompleted) {
          widget.animationController.value = 1;
        }
      }),
    );
    _bounceDragController.reverse();
  }

  bool _isCheckingShouldClose = false;

  FutureOr<bool> shouldClose() async {
    if (_isCheckingShouldClose) {
      return false;
    }
    if (widget.shouldClose == null) {
      return false;
    }
    _isCheckingShouldClose = true;
    final bool? result = await widget.shouldClose?.call();
    _isCheckingShouldClose = false;
    return result ?? false;
  }

  ParametricCurve<double> animationCurve = Curves.linear;

  Future<void> _handleDragUpdate(double primaryDelta) async {
    animationCurve = Curves.linear;
    assert(widget.enableDrag, "Dragging is disabled");

    if (_dismissUnderway) {
      return;
    }
    isDragging = true;

    final double progress = primaryDelta / (_childHeight ?? primaryDelta);

    if (widget.shouldClose != null && hasReachedWillPopThreshold) {
      _cancelClose();
      final bool canClose = await shouldClose();
      if (canClose) {
        _close();
        return;
      } else {
        _cancelClose();
      }
    }

    // Bounce top
    final bool bounce = widget.bounce;
    final bool shouldBounce = _bounceDragController.value > 0;
    final bool isBouncing = (widget.animationController.value - progress) > 1;
    if (bounce && (shouldBounce || isBouncing)) {
      _bounceDragController.value -= progress * 10;
      return;
    }

    widget.animationController.value -= progress;
  }

  Future<void> _handleDragEnd(double velocity) async {
    assert(widget.enableDrag, "Dragging is disabled");

    animationCurve = BottomSheetSuspendedCurve(
      widget.animationController.value,
      curve: _defaultCurve,
    );

    if (_dismissUnderway || !isDragging) {
      return;
    }
    isDragging = false;
    await _bounceDragController.reverse();

    Future<void> tryClose() async {
      if (widget.shouldClose != null) {
        _cancelClose();
        final bool canClose = await shouldClose();
        if (canClose) {
          _close();
        }
      } else {
        _close();
      }
    }

    // If speed is bigger than _minFlingVelocity try to close it
    if (velocity > widget.minFlingVelocity) {
      await tryClose();
    } else if (hasReachedCloseThreshold) {
      if (widget.animationController.value > 0.0) {
        await widget.animationController.fling(velocity: -1);
      }
      await tryClose();
    } else {
      _cancelClose();
    }
  }

  // As we cannot access the dragGesture detector of the scroll view
  // we can not know the DragDownDetails and therefore the end velocity.
  // VelocityTracker it is used to calculate the end velocity  of the scroll
  // when user is trying to close the modal by dragging
  VelocityTracker? _velocityTracker;
  DateTime? _startTime;

  void _handleScrollUpdate(ScrollNotification notification) {
    assert(notification.context != null, "");
    //Check if scrollController is used
    if (!_scrollController.hasClients) {
      return;
    }

    ScrollPosition scrollPosition;

    if (_scrollController.positions.length > 1) {
      scrollPosition = _scrollController.positions.firstWhere(
        (ScrollPosition p) => p.isScrollingNotifier.value,
        orElse: () => _scrollController.positions.first,
      );
    } else {
      scrollPosition = _scrollController.position;
    }

    if (scrollPosition.axis == Axis.horizontal) {
      return;
    }

    final bool isScrollReversed =
        scrollPosition.axisDirection == AxisDirection.down;
    final double offset = isScrollReversed
        ? scrollPosition.pixels
        : scrollPosition.maxScrollExtent - scrollPosition.pixels;

    if (offset <= 0) {
      // Clamping Scroll Physics end with a ScrollEndNotification with a DragEndDetail class
      // while Bouncing Scroll Physics or other physics that Overflow don't return a drag end info

      // We use the velocity from DragEndDetail in case it is available
      if (notification is ScrollEndNotification) {
        final DragEndDetails? dragDetails = notification.dragDetails;
        if (dragDetails != null) {
          _handleDragEnd(dragDetails.primaryVelocity ?? 0);
          _velocityTracker = null;
          _startTime = null;
          return;
        }
      }

      // Otherwise the calculate the velocity with a VelocityTracker
      if (_velocityTracker == null) {
        final PointerDeviceKind pointerKind = defaultPointerDeviceKind(context);
        _velocityTracker = VelocityTracker.withKind(pointerKind);
        _startTime = DateTime.now();
      }

      DragUpdateDetails? dragDetails;
      if (notification is ScrollUpdateNotification) {
        dragDetails = notification.dragDetails;
      }
      if (notification is OverscrollNotification) {
        dragDetails = notification.dragDetails;
      }
      assert(_velocityTracker != null, "");
      assert(_startTime != null, "");
      final DateTime startTime = _startTime!;
      final VelocityTracker velocityTracker = _velocityTracker!;
      if (dragDetails != null) {
        final Duration duration = startTime.difference(DateTime.now());
        velocityTracker.addPosition(duration, Offset(0, offset));
        _handleDragUpdate(dragDetails.delta.dy);
      } else if (isDragging) {
        final double velocity =
            velocityTracker.getVelocity().pixelsPerSecond.dy;
        _velocityTracker = null;
        _startTime = null;
        _handleDragEnd(velocity);
      }
    }
  }

  Curve get _defaultCurve => widget.animationCurve ?? _decelerateEasing;

  @override
  void initState() {
    animationCurve = _defaultCurve;
    _bounceDragController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CurvedAnimation bounceAnimation = CurvedAnimation(
      parent: _bounceDragController,
      curve: Curves.easeOutSine,
    );

    Widget child = widget.child;
    if (widget.containerBuilder != null) {
      child = widget.containerBuilder!(
        context,
        widget.animationController,
        child,
      );
    }

    child = AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget? child) {
        assert(child != null, "child is null");
        final double animationValue = animationCurve.transform(
          widget.animationController.value,
        );

        final Widget? draggableChild = !widget.enableDrag
            ? child
            : KeyedSubtree(
                key: _childKey,
                child: AnimatedBuilder(
                  animation: bounceAnimation,
                  builder: (BuildContext context, _) => CustomSingleChildLayout(
                    delegate: _CustomBottomSheetLayout(bounceAnimation.value),
                    child: GestureDetector(
                      onVerticalDragUpdate: (DragUpdateDetails details) {
                        _handleDragUpdate(details.delta.dy);
                      },
                      onVerticalDragEnd: (DragEndDetails details) {
                        _handleDragEnd(details.primaryVelocity ?? 0);
                      },
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification notification) {
                          _handleScrollUpdate(notification);
                          return false;
                        },
                        child: child!,
                      ),
                    ),
                  ),
                ),
              );
        return ClipRect(
          child: CustomSingleChildLayout(
            delegate: _ModalBottomSheetLayout(
              animationValue,
              widget.expanded,
            ),
            child: draggableChild,
          ),
        );
      },
      child: RepaintBoundary(child: child),
    );

    return StatusBarGestureDetector(
      child: child,
      onTap: (_) async {
        await _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutCirc,
        );
      },
    );
  }
}

class _ModalBottomSheetLayout extends SingleChildLayoutDelegate {
  _ModalBottomSheetLayout(this.progress, this.expand);

  final double progress;
  final bool expand;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        minHeight: expand ? constraints.maxHeight : 0,
        maxHeight: expand ? constraints.maxHeight : constraints.minHeight,
      );

  @override
  Offset getPositionForChild(Size size, Size childSize) =>
      Offset(0, size.height - childSize.height * progress);

  @override
  bool shouldRelayout(_ModalBottomSheetLayout oldDelegate) =>
      progress != oldDelegate.progress;
}

class _CustomBottomSheetLayout extends SingleChildLayoutDelegate {
  _CustomBottomSheetLayout(this.progress);

  final double progress;
  double? childHeight;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        minHeight: constraints.minHeight,
        maxHeight: constraints.maxHeight + progress * 8,
      );

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    childHeight ??= childSize.height;
    return Offset(0, size.height - childSize.height);
  }

  @override
  bool shouldRelayout(_CustomBottomSheetLayout oldDelegate) {
    if (progress != oldDelegate.progress) {
      childHeight = oldDelegate.childHeight;
      return true;
    }
    return false;
  }
}

// Checks the device input type as per the OS installed in it
// Mobile platforms will be default to `touch` while desktop will do to `mouse`
// Used with VelocityTracker
// https://github.com/flutter/flutter/pull/64267#issuecomment-694196304
PointerDeviceKind defaultPointerDeviceKind(BuildContext context) {
  final TargetPlatform platform =
      Theme.of(context).platform; // ?? defaultTargetPlatform;
  switch (platform) {
    case TargetPlatform.iOS:
    case TargetPlatform.android:
      return PointerDeviceKind.touch;
    case TargetPlatform.linux:
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
      return PointerDeviceKind.mouse;
    case TargetPlatform.fuchsia:
      return PointerDeviceKind.unknown;
  }
}