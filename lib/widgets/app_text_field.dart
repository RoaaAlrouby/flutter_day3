import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?) validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF00695C);
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: teal),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(color: teal, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}