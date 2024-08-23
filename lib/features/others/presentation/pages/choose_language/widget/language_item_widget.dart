import "package:flutter/material.dart";
import "package:currency_clean_architecture/core/extension/extension.dart";
import "package:currency_clean_architecture/core/utils/utils.dart";

class LanguageItemWidget extends StatelessWidget {
  const LanguageItemWidget({
    super.key,
    required this.text,
    this.check,
    required this.assets,
    this.onTap,
  });

  final void Function()? onTap;
  final String text;
  final bool? check;
  final String assets;

  @override
  Widget build(BuildContext context) => Material(
        color: context.color.background,
        borderRadius: AppUtils.kBorderRadius12,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppUtils.kBorderRadius12,
          child: Padding(
            padding: AppUtils.kPaddingAll16,
            child: Row(
              children: <Widget>[
                Image.asset(
                  "assets/images/$assets.png",
                  semanticLabel: "",
                  width: 32,
                  height: 32,
                ),
                AppUtils.kGap12,
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight:
                        check == null ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
                AppUtils.kSpacer,
                if (check != null) RadioButton(value: check!),
              ],
            ),
          ),
        ),
      );
}

class RadioButton extends StatelessWidget {
  const RadioButton({
    super.key,
    required this.value,
    this.size = 24,
  });

  final bool value;
  final double size;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        width: size,
        height: size,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          shape: BoxShape.circle,
          border: Border.all(
            color: value
                ? context.colorScheme.primary
                : context.colorScheme.outline,
            width: 0.5,
          ),
        ),
        child: Icon(
          Icons.circle,
          color: value
              ? context.colorScheme.primary
              : context.colorScheme.onPrimary,
          size: size / 4,
        ),
      );
}
