import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextSignUp extends StatelessWidget {
  const CustomTextSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    // Tema renk şeması
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ), // Üst ve alt boşluk ekler
      child: Column(
        children: <Widget>[
          // Başlık metni "Let's Get Started"
          Text(
            "lets_get_started".tr(),
            style: GoogleFonts.montserrat(
              fontSize: 24, // Font boyutu
              fontWeight: FontWeight.bold, // Font kalınlığı
            ),
          ),
          // Alt açıklama metni
          Text(
            'create_an_account'.tr(),
            style: GoogleFonts.montserrat(
              fontSize: 14, // Font boyutu
              fontWeight: FontWeight.bold, // Font kalınlığı
              color: colorScheme.onSurfaceVariant.withValues(
                alpha: 0.7,
              ), // Renk, tema ile uyumlu
            ),
          ),
        ],
      ),
    );
  }
}
