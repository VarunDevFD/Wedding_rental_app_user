import 'package:flutter/material.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool isPasswordField;
  final TextEditingController controller;
  final String? Function(String? value) validator; // Validator added here

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.isPasswordField = false,
    required this.controller,
    required this.validator, // Pass the validator through the constructor
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: AppTextStyles.subTitleStyle,
          ),
          const SizedBox(height: 8.0),
          TextFormField( // Changed to TextFormField to support validation
            controller: widget.controller,
            obscureText: widget.isPasswordField ? _obscureText : false,
            validator: widget.validator, // Apply the validator here
            decoration: InputDecoration(
              hintText: widget.hintText,
              filled: true,
              fillColor: const Color(0xFFE1F5FE), // Light green background color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none, // Remove border
              ),
              suffixIcon: widget.isPasswordField
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
