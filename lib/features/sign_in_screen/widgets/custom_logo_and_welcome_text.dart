import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLogoAndWelcomeText extends StatelessWidget {
  const CustomLogoAndWelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    // Ekranın yüksekliğini alıyoruz
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;
    // Tema renk şeması
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // Tema metin stilleri
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: <Widget>[
        // LOGO metni, büyük boyut ve kalın yazı tipiyle
        Text(
          'LOGO',
          style: GoogleFonts.montserrat(
            fontSize: 64, // Font boyutu
            fontWeight: FontWeight.bold, // Kalın yazı
            color: colorScheme.primary, // Tema renk şeması ile uyumlu renk
          ),
        ),
        SizedBox(height: ekranYuksekligi / 13), // LOGO ve diğer metinler arasında boşluk bırakıyoruz
        // Hoş geldiniz metni
        Text(
          'Welcome Back!',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold, // Metnin kalın olmasını sağlıyoruz
          ),
        ),
        const SizedBox(height: 10), // Hoş geldiniz ve giriş metinleri arasında boşluk
        // "Login to your account" metni
        Text(
          'Login to your account',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.7), // Yumuşak bir renk tonu
          ),
        ),
        const SizedBox(height: 30), // Sonra gelen elemanlara boşluk bırakıyoruz
      ],
    );
  }
}
