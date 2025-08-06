import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yeni_tasarim/providers/all_providers.dart';

class CustomSignInOrientation extends ConsumerWidget {
  const CustomSignInOrientation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tema renk şeması
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // Tema metin stilini alıyoruz
    TextTheme textTheme = Theme.of(context).textTheme;

    // Kullanıcı kaydının mı yoksa giriş yapma ekranının mı olduğu bilgisini alıyoruz
    bool kayitMi = ref.watch(kayitMiProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Elemanları yatayda ortalar
      children: <Widget>[
        // Kullanıcıya mesaj metni
        Text(
          'already'.tr(),
          style: textTheme.bodyMedium, // Temaya uygun metin stili
        ),
        // "Login here" butonu, tıklanınca kayitMi durumu değişir
        TextButton(
          onPressed: () {
            // Kullanıcı butona tıkladığında, kayitMi'nin değerini tersine çeviriyoruz
            ref.read(kayitMiProvider.notifier).state = !kayitMi;
          },
          child: Text(
            'login_here'.tr(),
            style: TextStyle(
              fontSize: 18, // Metin boyutu
              color: colorScheme.onSurface, // Metin rengi tema ile uyumlu
              fontWeight: FontWeight.bold, // Metin kalınlığı
            ),
          ),
        ),
      ],
    );
  }
}
