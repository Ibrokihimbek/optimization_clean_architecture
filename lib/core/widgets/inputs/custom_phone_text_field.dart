import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:currency_clean_architecture/core/extension/extension.dart";
import "package:currency_clean_architecture/core/widgets/inputs/masked_text_input_formatter.dart";

class CustomPhoneTextField extends StatefulWidget {
  const CustomPhoneTextField({
    this.controller,
    super.key,
    this.titleText,
    this.showError,
    this.autoFocus = false,
    this.onChanged,
    this.prefixText,
    this.errorText,
    this.inputAction,
    this.currentFocus,
    this.nextFocus,
    this.obscureText,
    this.hintText,
    this.context,
    this.onTap,
    this.readOnly = false,
    this.suffixText,
    this.suffixIcon,
    this.suffixStyle,
    this.prefixIcon,
    this.fillColor,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.onComplete,
    this.required = false,
    this.labelText,
    this.validator,
    this.filled,
    this.haveBorder = true,
  });

  final String? titleText;
  final String? labelText;
  final bool? showError;
  final TextEditingController? controller;
  final bool autoFocus;
  final void Function(String value)? onChanged;
  final String? prefixText;
  final String? errorText;
  final TextInputAction? inputAction;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final String? hintText;
  final bool? obscureText;
  final BuildContext? context;
  final void Function()? onTap;
  final void Function()? onComplete;
  final bool readOnly;
  final String? suffixText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? suffixStyle;
  final Color? fillColor;
  final EdgeInsets? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final bool required;
  final String? Function(String?)? validator;
  final bool? filled;
  final bool haveBorder;

  @override
  State<CustomPhoneTextField> createState() => _CustomPhoneTextFieldState();
}

class _CustomPhoneTextFieldState extends State<CustomPhoneTextField> {
  String? _prefixText;
  late FocusNode focusNode = widget.currentFocus ?? FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      setState(() {
        _prefixText = "+998 ";
      });
      // focusNode.addListener(() {
      //     setState(() {
      //       _prefixText = "+998 ";
      //     });
      //   if (focusNode.hasFocus) {
      //     setState(() {
      //       _prefixText = "+998 ";
      //     });
      //   } else {
      //     if ((widget.controller?.text ?? "").isEmpty) {
      //       setState(() {
      //         _prefixText = null;
      //       });
      //     }
      //   }
      // });
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (widget.titleText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                "${widget.titleText}",
                style: const TextStyle(
                  fontSize: 14,
                  height: 20 / 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF344054),
                ),
              ),
            ),
          TextFormField(
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.disabled,
            inputFormatters: <TextInputFormatter>[
              MaskedTextInputFormatter(
                mask: "## ### ## ##",
                separator: " ",
                filter: RegExp("[0-9]"),
              ),
            ],
            style: context.textTheme.titleMedium,
            obscureText: widget.obscureText ?? false,
            readOnly: widget.readOnly,
            controller: widget.controller,
            focusNode: focusNode,
            onTap: widget.onTap,
            scrollPadding: EdgeInsets.zero,
            autofocus: widget.autoFocus,
            onChanged: widget.onChanged,
            onFieldSubmitted: (String term) => _fieldFocusChange(
              context,
              focusNode,
              widget.nextFocus,
            ),
            obscuringCharacter: "*",
            textInputAction: widget.inputAction,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              fillColor: widget.fillColor,
              filled: widget.filled,
              suffixIcon: widget.suffixIcon,
              labelText: widget.labelText,
              prefixText: _prefixText,
              prefixStyle: context.textTheme.titleMedium,
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Color(0xFF667085),
                fontWeight: FontWeight.w500,
              ),
              errorStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: const SizedBox(width: 14),
              prefixIconConstraints: const BoxConstraints(),
              contentPadding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
              hintText: _prefixText == null ? widget.hintText : "",
              errorText: widget.showError ?? false ? widget.errorText : null,
            ),
            cursorColor: context.theme.colorScheme.primary,
            keyboardType: TextInputType.phone,
            onEditingComplete: widget.onComplete,
          ),
        ],
      );

  void _fieldFocusChange(
    BuildContext context,
    FocusNode? currentFocus,
    FocusNode? nextFocus,
  ) {
    if (currentFocus != null && nextFocus != null) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }
}
