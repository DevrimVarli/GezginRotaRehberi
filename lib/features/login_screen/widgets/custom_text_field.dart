import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  TextEditingController controller ;
  String label;
  CustomTextField({super.key,required this.controller,required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent.withValues(alpha: 0.58),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            labelText: label,
            labelStyle: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color: Colors.white.withValues(alpha: 0.95)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.white,width: 1.75),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.white,width: 2.5),
            )
        ));
  }
}
