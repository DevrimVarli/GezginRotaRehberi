import 'package:flutter/material.dart';
class CustomTextFormField extends StatelessWidget {


  const CustomTextFormField({required this.obscureText, required this.icon, required this.tfc, required this.validator,
      required this.hintText, required this.colorScheme, super.key,});
  final bool obscureText;
  final Icon icon;
  final TextEditingController tfc;
  final String? Function(String?) validator;
  final String hintText;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller:tfc ,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
        filled: true,
        fillColor: colorScheme.onSurface.withValues(alpha: 0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),);
  }
}
