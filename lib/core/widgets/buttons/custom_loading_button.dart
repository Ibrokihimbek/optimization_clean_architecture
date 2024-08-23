import "package:flutter/material.dart";
import "package:pizza_hut_client_mobile/core/widgets/loading/circular_progress_indicator.dart";

class CustomLoadingButton extends StatelessWidget {
  const CustomLoadingButton({
    required this.child,
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.style,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final bool isLoading;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isLoading
              ? const CustomCircularProgressIndicator(
                  size: 24,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : child,
          layoutBuilder: (
            Widget? currentChild,
            List<Widget> currentChildKeys,
          ) =>
              Stack(
            children: <Widget>[
              ...currentChildKeys.map(
                (Widget currentChildKey) => Positioned.fill(
                  child: currentChildKey,
                ),
              ),
              if (currentChild != null) Align(child: currentChild),
            ],
          ),
        ),
      );
}
