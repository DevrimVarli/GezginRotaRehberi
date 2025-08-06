import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Tema renk düzenini almak için kullanılan değişken
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      title: Text(
        'my_favorites'.tr(), // AppBar başlığı
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w500, // Yazı kalınlığı
          fontSize: 30, // Yazı boyutu
          color: colorScheme.primary, // Yazı rengi, tema ile uyumlu
        ),
      ),
      centerTitle: true, // Başlığın ortalanması
    );
  }
}
