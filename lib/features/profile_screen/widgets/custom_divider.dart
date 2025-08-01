import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    double ekranGenisligi = MediaQuery.sizeOf(context).width; // Ekranın genişliğini alıyoruz
    ColorScheme colorScheme = Theme.of(context).colorScheme; // Tema renk şemalarını alıyoruz

    return Container(
      width: ekranGenisligi, // Divider'ın genişliği ekranın genişliğine eşit olacak
      height: 1.5, // Divider'ın yüksekliği 1.5 birim
      color: colorScheme.onSurface.withValues(alpha: 0.1), // Divider'ın rengi, tema ile uyumlu ve %10 opaklık
    );
  }
}
