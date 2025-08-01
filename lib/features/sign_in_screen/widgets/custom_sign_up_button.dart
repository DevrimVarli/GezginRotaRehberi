import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';

class CustomSignUpButton extends ConsumerWidget {
  const CustomSignUpButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tema renk şeması ve metin stillerini alıyoruz
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    // `kayitMi` değeri, kullanıcının kayıt sayfasında olup olmadığını kontrol eder
    bool kayitMi = ref.watch(kayitMiProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Butonları ortalar
      children: <Widget>[
        // "Don't have an account?" metni
        Text(
          "Don't have an account?",
          style: textTheme.bodyMedium, // Metin stili
        ),
        // "Sign Up" butonu
        TextButton(
          onPressed: () {
            // `kayitMiProvider`'ın değerini tersine çevirerek, sayfalar arasında geçiş yapar
            ref.read(kayitMiProvider.notifier).state = !kayitMi;
          },
          child: Text(
            'Sign Up',
            style: TextStyle(color: colorScheme.primary), // Buton metninin rengi tema ile uyumlu
          ),
        ),
      ],
    );
  }
}
