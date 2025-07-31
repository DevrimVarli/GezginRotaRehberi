import 'package:flutter/material.dart';
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, required this.controller, required this.textTheme, required this.colorScheme,
     required this.label,required this.validator,required this.readOnly,});
  final TextEditingController controller;
  final TextTheme textTheme;
  final ColorScheme colorScheme;
  final String label;
  final String? Function(String?)? validator;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
      child: TextFormField(
        readOnly: readOnly,
        validator: validator,
        controller: controller,
        style: textTheme.titleMedium,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: colorScheme.onSurface.withValues(alpha: 0.6),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
          ),
        ),
      ),
    );
  }
}
