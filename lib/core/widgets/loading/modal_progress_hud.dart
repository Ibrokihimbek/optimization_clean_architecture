import "package:flutter/material.dart";

import "package:currency_clean_architecture/core/widgets/loading/circular_progress_indicator.dart";

class ModalProgressHUD extends StatelessWidget {
  const ModalProgressHUD({
    required this.child,
    super.key,
    this.inAsyncCall = false,
    this.opacity = 0.3,
    this.color = Colors.transparent,
    this.progressIndicator = const CustomCircularProgressIndicator.adaptive(),
    this.dismissible = false,
  });

  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final bool dismissible;
  final Widget child;

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          child,
          Offstage(
            offstage: !inAsyncCall,
            child: AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 100),
              child: ModalBarrier(dismissible: dismissible, color: color),
            ),
          ),
          Offstage(
            offstage: !inAsyncCall,
            child: Center(child: progressIndicator),
          ),
        ],
      );
}
