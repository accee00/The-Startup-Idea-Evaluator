import 'package:ai_voting_app/core/extension%20/build_context_extension.dart';
import 'package:flutter/material.dart';

class CustomInputFeild extends StatefulWidget {
  const CustomInputFeild({
    super.key,
    required this.controller,
    this.maxLines = 1,
    required this.hintText,
    this.validator,
    this.prefixIcon,
    this.obscureText,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final int? maxLines;
  final String hintText;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final bool? obscureText;
  final IconButton? suffixIcon;

  @override
  State<CustomInputFeild> createState() => _CustomInputFeildState();
}

class _CustomInputFeildState extends State<CustomInputFeild> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText ?? false,

      maxLines: widget.maxLines,
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: context.colorScheme.onSurface.withAlpha(150),
              )
            : null,
        suffixIcon: widget.suffixIcon,
        hintText: widget.hintText,
        hintStyle: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.onSurface.withAlpha(150),
        ),
      ),
    );
  }
}
