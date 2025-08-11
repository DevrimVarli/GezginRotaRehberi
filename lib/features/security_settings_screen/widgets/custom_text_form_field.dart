import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.obscureText,
    required this.icon,
    required this.tfc,
    required this.validator,
    required this.hintText,
    required this.colorScheme,
    super.key,
  });

  // Bu widget'ın parametreleri
  final bool obscureText; // Şifrelenecek metin (şifre alanı için kullanılır)
  final Icon icon; // Input alanının başında gösterilecek ikon
  final TextEditingController tfc; // Metin düzenleyicisi (controller)
  final String? Function(String?) validator; // Doğrulama fonksiyonu
  final String hintText; // Placeholder metni
  final ColorScheme colorScheme; // Tema renk düzeni
  void dispose() {
    // TextEditingController'ı temizler
    tfc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText, // Şifre alanlarında metni gizler
      validator: validator, // Doğrulama fonksiyonu
      controller: tfc, // TextField'ın kontrolcüsü
      decoration: InputDecoration(
        hintText: hintText, // Placeholder metni
        prefixIcon: icon, // Başlangıçta gösterilecek ikon
        filled: true, // Arka plan rengini dolu yapar
        fillColor: colorScheme.onSurface.withValues(
          alpha: 0.2,
        ), // Arka plan rengi, %20 opaklıkla
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Kenar yuvarlama
          borderSide: BorderSide.none, // Sınır çizgisi yok
        ),
      ),
    );
  }
}
