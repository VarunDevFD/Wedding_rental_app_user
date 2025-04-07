import 'package:flutter/material.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_colors.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator; // Add validator parameter
  final void Function(String)? onSubmitted;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.focusNode,
    this.validator, // Initialize validator in the constructor
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField( // Change TextField to TextFormField
      controller: controller,
      obscureText: obscureText,
      focusNode: focusNode,
      onFieldSubmitted: onSubmitted,
      validator: validator, // Use validator
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        filled: true,
        fillColor: AppColors.backgroundColor.withAlpha((0.3 * 255).round()),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        labelStyle: AppTextStyles.customButtonTextStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.buttonTextColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
