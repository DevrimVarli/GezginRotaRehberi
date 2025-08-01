import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextName extends StatelessWidget {

  const CustomTextName({super.key, required this.mekanAd});

  final String mekanAd; // Mekan adı

  @override
  Widget build(BuildContext context) {
    // Tema renk düzenini almak için kullanılan değişken
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Positioned(
      top: 10, // Ekranın üst kısmından 10 birim uzaklıkta
      left: 10, // Ekranın sol kısmından 10 birim uzaklıkta
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10), // Yatayda padding ekliyoruz
        height: 40, // Konteynerin yüksekliği
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.8), // Arka plan rengini temadan alıyoruz ve opaklık ekliyoruz
          borderRadius: BorderRadius.circular(8), // Yuvarlatılmış köşeler
        ),
        child: Center(
          child: Text(
            mekanAd, // Mekan adını gösteriyoruz
            style: GoogleFonts.montserrat(
              fontSize: 16, // Yazı boyutu
              color: colorScheme.onSurface, // Yazı rengi temadan alınır
              fontWeight: FontWeight.w500, // Yazı kalınlığı
            ),
          ),
        ),
      ),
    );
  }
}
