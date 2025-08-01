import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  const InfoTile(this.title, this.value, {super.key});

  final String title; // Başlık metni
  final String value; // Değer metni

  @override
  Widget build(BuildContext context) {
    // Tema renk düzenini almak için kullanılan değişken
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // Tema metin stillerini almak için kullanılan değişken
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity, // Container genişliği, ekranın tamamına yayılır
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Container içi padding
      margin: const EdgeInsets.symmetric(vertical: 8), // Container dışı margin (yukarı ve aşağıya boşluk ekler)
      decoration: BoxDecoration(
        color: colorScheme.onSurface.withValues(alpha: 0.1), // Arka plan rengi, tema ile uyumlu ve %10 opaklıkta
        borderRadius: BorderRadius.circular(12), // Yuvarlatılmış köşeler
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Metinleri sola hizalar
        children: <Widget>[
          // Başlık metni
          Text(
            title,
            style: textTheme.labelLarge?.copyWith(
              color: colorScheme.onSurface, // Başlık yazısının rengi
              fontWeight: FontWeight.w600, // Başlık yazısının kalınlığı
              fontSize: 14, // Başlık yazısının boyutu
            ),
          ),
          const SizedBox(height: 4), // Başlık ve değer arasına boşluk ekler
          // Değer metni
          Text(
            value.isNotEmpty ? value : 'Bilinmiyor', // Eğer value boşsa "Bilinmiyor" yazısını gösterir
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.9), // Değer yazısının rengi
            ),
          ),
        ],
      ),
    );
  }
}
