import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final GlobalKey<FormFieldState>? fieldKey;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  final String? label;
  final String? hint;
  final String? Function(String?)? validator;

  final bool readOnly;
  final bool isMultiline;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final bool isDisabled;
  final String? prefixText;
  final TextStyle? prefixStyle;

  final bool cursor;
  final bool isDense;
  final bool isObscure;
  final double radius;

  const AppTextField({
    super.key,
    this.fieldKey,
    this.focusNode,
    this.controller,
    this.label,
    this.hint,
    this.validator,
    this.readOnly = false,
    this.isMultiline = false,
    this.keyboardType,
    this.onTap,
    this.onChanged,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.isDisabled = false,
    this.prefixText,
    this.prefixStyle,
    this.cursor = false,
    this.isDense = true,
    this.isObscure = false,
    this.radius = 14,
  });

  @override
  Widget build(BuildContext context) {
    final textController = controller ?? TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          key: fieldKey,
          focusNode: focusNode,
          controller: textController,
          validator: validator,
          cursorColor: Colors.black,
          inputFormatters: inputFormatters,
          readOnly: readOnly,
          showCursor: cursor,
          obscureText: isObscure,
          onTap: onTap,
          onChanged: onChanged,
          maxLines: isMultiline ? null : 1,
          maxLength: isMultiline ? 200 : null,
          buildCounter: isMultiline ? (_, {required int currentLength, required int? maxLength, required bool isFocused}) => null : null,
          keyboardType: keyboardType ?? (isMultiline ? TextInputType.multiline : TextInputType.text),
          textCapitalization: _getCapitalization(),
          style: TextStyle(
            fontSize: 16,
            color: isDisabled ? Colors.grey : Colors.black,
          ),
          decoration: InputDecoration(
            filled: true,
            isDense: isDense,
            labelText: label,
            hintText: hint,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            prefixText: prefixText,
            prefixStyle: prefixStyle,
            fillColor: Colors.grey.shade100,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            floatingLabelStyle: const TextStyle(color: Colors.black),
            contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                width: 0.5,
                color: Colors.grey.shade400,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),

        /// 🔢 Counter multiline (AMAN saat rebuild)
        if (isMultiline && controller != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller!,
                builder: (_, value, __) {
                  return Text(
                    '${value.text.length}/200',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  TextCapitalization _getCapitalization() {
    if (keyboardType == TextInputType.emailAddress) return TextCapitalization.none;
    if (keyboardType == TextInputType.number) return TextCapitalization.none;
    if (keyboardType == TextInputType.phone) return TextCapitalization.none;
    return TextCapitalization.none;
  }
}
