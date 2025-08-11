import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.textTheme,
    required this.colorScheme,
    required this.label,
    required this.validator,
    required this.readOnly,
  });

  // Form verilerini almak için kullanılan controller
  final TextEditingController controller;
  // Tema stilini alacak olan textTheme
  final TextTheme textTheme;
  // Renk düzenini alacak olan colorScheme
  final ColorScheme colorScheme;
  // Etiket metni
  final String label;
  // Formun doğrulama fonksiyonu
  final String? Function(String?)? validator;
  // Alanın sadece okunabilir olup olmadığını belirler
  final bool readOnly;
  void dispose() {
    // TextEditingController'ı temizler
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ), // Padding ile alanın etrafında boşluk bırakılır
      child: TextFormField(
        readOnly: readOnly, // Eğer true ise kullanıcı bu alanı düzenleyemez
        validator: validator, // Validator ile form doğrulaması yapılır
        controller:
            controller, // Formun verisini almak için controller kullanılır
        style: textTheme.titleMedium, // Text stilini tema ile uyumlu yapıyoruz
        decoration: InputDecoration(
          labelText: label, // Form alanının etiketi
          labelStyle: textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurface.withValues(
              alpha: 0.6,
            ), // Etiket rengi tema ile uyumlu olur
          ),
          filled: true, // Arka plan renginin dolu olmasını sağlar
          fillColor: Colors.transparent, // Arka plan rengini şeffaf yapar
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20, // İçeriğin yatayda padding alması
            vertical: 18, // İçeriğin dikeyde padding alması
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ), // Kenar yuvarlama
            borderSide: BorderSide(
              color: colorScheme.onSurface.withValues(
                alpha: 0.6,
              ), // Normal durumdaki kenar rengi
              width: 2, // Kenar çizgi kalınlığı
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ), // Kenar yuvarlama
            borderSide: BorderSide(
              color: colorScheme.primary, // Fokus durumunda kenar rengi
              width: 2, // Kenar çizgi kalınlığı
            ),
          ),
        ),
      ),
    );
  }
}
