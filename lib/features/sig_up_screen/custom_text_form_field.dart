import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTextFormField extends ConsumerWidget {
  const CustomTextFormField({
    super.key,
    required this.tfc,
    required this.validator,
    required this.hintText,
    required this.obscureText,
    required this.icon,
  });

  // Giriş alanının kontrolcüsü (TextEditingController)
  final TextEditingController tfc;

  // Giriş alanı için doğrulama fonksiyonu
  final String? Function(String?)? validator;

  // Placeholder metni
  final String hintText;

  // Metnin gizlenip gizlenmeyeceği (şifre alanları için kullanılır)
  final bool obscureText;

  // Giriş alanının başında gösterilecek ikon
  final Icon icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TextEditingController'daki metni temizliyoruz (tüm alanlar için boş başlatma)
    tfc.text = '';

    // Tema renk şemasını alıyoruz
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      obscureText: obscureText, // Şifre alanlarında metni gizler
      validator: validator, // Giriş verisini doğrulama işlemi
      controller: tfc, // Kontrolcü ile metin girişini yönetir
      decoration: InputDecoration(
        hintText: hintText, // Placeholder metni
        prefixIcon: icon, // Alanın başındaki ikon
        filled: true, // Alanın arka plan rengini aktif eder
        fillColor: colorScheme.onSurfaceVariant.withValues(alpha: 0.05), // Arka plan rengi, tema ile uyumlu
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Alanın yuvarlatılmış köşeleri
          borderSide: BorderSide.none, // Sınır çizgisi yok
        ),
      ),
    );
  }
}
