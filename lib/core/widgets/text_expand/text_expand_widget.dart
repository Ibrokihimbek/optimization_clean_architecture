import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:currency_clean_architecture/core/extension/extension.dart";

class TextExpandWidget extends StatefulWidget {
  const TextExpandWidget({
    super.key,
    required this.text,
    required this.maxTextLength,
    this.expandTextColor,
    this.expandTextDecoration,
    this.expandTextDecorationColor,
    this.textFontSize,
    this.textFontWeight,
    this.expandTextFontSize,
    this.expandTextFontWeight,
    this.isTextButtonSpace,
  });

  final String text;
  final Color? expandTextColor;
  final TextDecoration? expandTextDecoration;
  final Color? expandTextDecorationColor;
  final double? textFontSize;
  final FontWeight? textFontWeight;
  final double? expandTextFontSize;
  final FontWeight? expandTextFontWeight;
  final int maxTextLength;
  final bool? isTextButtonSpace;

  @override
  State<TextExpandWidget> createState() => _TextExpandWidgetState();
}

class _TextExpandWidgetState extends State<TextExpandWidget> {
  bool isTitleExpanded = false;

  @override
  Widget build(BuildContext context) => RichText(
        text: TextSpan(
          children: <InlineSpan>[
            TextSpan(
              text: widget.text.substring(
                0,
                !isTitleExpanded
                    ? (widget.text.length > widget.maxTextLength
                        ? widget.maxTextLength
                        : widget.text.length)
                    : widget.text.length,
              ),
              style: TextStyle(
                fontSize: widget.textFontSize,
                fontWeight: widget.textFontWeight,
                color: context.color.secondaryText,
              ),
            ),
            TextSpan(
              text:
                  !isTitleExpanded && widget.text.length > widget.maxTextLength
                      ? "..."
                      : "",
              style: TextStyle(
                fontSize: widget.textFontSize,
                fontWeight: widget.textFontWeight,
                color: context.color.secondaryText,
              ),
            ),
            TextSpan(
              text: !isTitleExpanded
                  ? (widget.text.length > widget.maxTextLength
                      ? textButtonExpand
                      : "")
                  : textButtonCollapse,
              style: TextStyle(
                fontSize: widget.expandTextFontSize,
                fontWeight: widget.expandTextFontWeight,
                color: widget.expandTextColor,
                decoration: widget.expandTextDecoration,
                decorationColor: widget.expandTextDecorationColor,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    isTitleExpanded = !isTitleExpanded;
                  });
                },
            ),
          ],
        ),
      );

  String get textButtonExpand => widget.isTextButtonSpace ?? false
      ? "\n\n${context.tr("expand")} "
      : "\n${context.tr("expand")}";

  String get textButtonCollapse => widget.isTextButtonSpace ?? false
      ? "\n\n${context.tr("collapse")} "
      : "\n${context.tr("collapse")} ";
}
