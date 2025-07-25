import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class CustomTextFormField extends ConsumerWidget {
  const CustomTextFormField({super.key,required this.tfc,required this.validator,required this.hintText,required this.obscureText,required this.icon});
  final TextEditingController tfc;
  final String? Function(String?)? validator;
  final String hintText;
  final bool obscureText;
  final Icon icon;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    tfc.text='';
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller:tfc ,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
        filled: true,
        fillColor: colorScheme.onSurfaceVariant.withValues(alpha: 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),);
  }
}
