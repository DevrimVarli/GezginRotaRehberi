import 'package:flutter/material.dart';
class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});


  @override
  Widget build(BuildContext context) {
    double ekranGenisligi = MediaQuery.sizeOf(context).width;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: ekranGenisligi,
      height: 1.5,
      color: colorScheme.onSurface.withValues(alpha: 0.1),
    );
  }
}
