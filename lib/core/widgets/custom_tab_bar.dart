import "package:flutter/material.dart";
import "package:currency_clean_architecture/core/extension/extension.dart";
import "package:currency_clean_architecture/core/utils/utils.dart";

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    this.controller,
    required this.tabs,
    this.onTap,
    this.padding = const EdgeInsets.fromLTRB(12, 0, 12, 8),
  });

  final TabController? controller;
  final List<Widget> tabs;
  final EdgeInsets padding;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding,
        child: Material(
          color: context.color.background,
          borderRadius: AppUtils.kBorderRadius12,
          child: TabBar(
            onTap: onTap,
            controller: controller,
            padding: AppUtils.kPaddingAll3,
            tabs: tabs,
          ),
        ),
      );
}
