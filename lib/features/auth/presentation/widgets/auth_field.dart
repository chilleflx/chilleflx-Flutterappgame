import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final bool obsecureText;
  final TextEditingController controller;
  final String? Function(String?)? validator; // Customizable validator

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obsecureText = false,
    this.validator, // Optional custom validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecureText,
      validator: validator ?? _defaultValidator, // Use custom validator or default
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ), // Padding inside the field
      ),
    );
  }

  // Default validator if no custom validator is provided
  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '$hintText is missing!';
    }
    return null;
  }
}