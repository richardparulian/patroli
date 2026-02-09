import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
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
  final ValueChanged? onChanged;
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
    this.radius = 14
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  int charCount = 0;

  @override
  void initState() {
    super.initState();
    
    charCount = widget.controller?.text.length ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          key: widget.fieldKey,
          focusNode: widget.focusNode,
          controller: widget.controller,
          validator: widget.validator,
          cursorColor: Colors.black,
          inputFormatters: widget.inputFormatters,
          style: TextStyle(
            fontSize: 16.0,
            color: widget.isDisabled ? Colors.grey : Colors.black,
          ),
          readOnly: widget.readOnly,
          showCursor: widget.cursor,
          obscureText: widget.isObscure,
          onTap: widget.onTap,
          // onChanged: widget.onChanged,
          onChanged: (val) {
            widget.onChanged?.call(val);
            if (widget.isMultiline) {
              setState(() => charCount = val.length);
            }
          },
          maxLines: widget.isMultiline ? null : 1,
          maxLength: widget.isMultiline ? 200 : null,
          buildCounter: widget.isMultiline ? (_, {required int currentLength, required int? maxLength, required bool isFocused}) => null : null,
          textCapitalization: _getCapitalization(),
          keyboardType: widget.keyboardType ?? (widget.isMultiline ? TextInputType.multiline : TextInputType.text),
          decoration: InputDecoration(
            filled: true,
            isDense: widget.isDense,
            labelText: widget.label,
            hintText: widget.hint,
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            prefixText: widget.prefixText,
            prefixStyle: widget.prefixStyle,
            fillColor: Colors.grey.shade100,
            hintStyle: TextStyle(
              fontSize: 14.0, 
              fontWeight: FontWeight.w300,
            ),
            labelStyle: TextStyle(
              fontSize: 14.0, 
              fontWeight: FontWeight.w300,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(widget.radius),
            ),
          ),
        ),
        if (widget.isMultiline)
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(top: 10, right: 10),
            child: Text('$charCount/200',
              style: TextStyle(
                fontSize: 12, 
                color: Colors.grey.shade600,
              ),
            ),
          ),
      ],
    );
  }

  TextCapitalization _getCapitalization() {
    if (widget.keyboardType == TextInputType.emailAddress) return TextCapitalization.none;
    if (widget.keyboardType == TextInputType.number) return TextCapitalization.none;
    if (widget.keyboardType == TextInputType.phone) return TextCapitalization.none;
    if (widget.isObscure || !widget.isObscure) return TextCapitalization.none;

    return TextCapitalization.sentences;
  }
}

String? requiredValidator(String? val) {
  if (val == null || val.trim().isEmpty) return 'Wajib diisi!';
  
  return null;
}

