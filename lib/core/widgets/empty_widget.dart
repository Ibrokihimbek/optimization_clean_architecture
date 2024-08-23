import "package:flutter/material.dart";
import "package:pizza_hut_client_mobile/core/extension/extension.dart";
import "package:pizza_hut_client_mobile/core/utils/utils.dart";

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.image,
    required this.text,
    required this.subText,
    this.child,
  });

  final Widget image;
  final String text;
  final String subText;
  final Widget? child;

  @override
  Widget build(BuildContext context) => SliverFillRemaining(
        child: SafeArea(
          top: false,
          minimum: AppUtils.kPaddingAll16,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              image,
              AppUtils.kGap8,
              Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppUtils.kGap8,
              Text(
                subText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: context.color.secondaryText,
                ),
              ),
              if (child != null) ...<Widget>[
                AppUtils.kGap16,
                child!,
              ],
            ],
          ),
        ),
      );
}
