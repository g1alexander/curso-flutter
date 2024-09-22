import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final bool obscureText;
  final IconData? prefixIcon;
  final String? hintText;
  final String? errorText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextFormField(
      {super.key,
      this.label,
      this.hintText,
      this.errorText,
      this.onChanged,
      this.validator,
      this.prefixIcon,
      this.obscureText = false});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(40));

    return TextFormField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder:
            border.copyWith(borderSide: BorderSide(color: colors.primary)),
        isDense: true,
        label: widget.label != null ? Text(widget.label!) : null,
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.black38),
        focusColor: colors.primary,
        prefixIcon: Icon(widget.prefixIcon,
            color: _focusNode.hasFocus ? colors.primary : Colors.black38),
        errorText: widget.errorText,
        errorBorder:
            border.copyWith(borderSide: BorderSide(color: colors.error)),
        focusedErrorBorder:
            border.copyWith(borderSide: BorderSide(color: colors.error)),
      ),
    );
  }
}
