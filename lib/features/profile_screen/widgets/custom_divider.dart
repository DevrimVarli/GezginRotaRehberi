import 'package:flutter/material.dart';
class CustomDivider extends StatelessWidget {
  CustomDivider(this.ekranGenisligi, {super.key});
  double ekranGenisligi;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: ekranGenisligi,
      height: 1.5,
      color: colorScheme.onSurface,
    );
  }
}
