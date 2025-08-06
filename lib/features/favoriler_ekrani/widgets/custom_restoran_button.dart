import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:yeni_tasarim/providers/all_providers.dart';

class CustomRestoranButton extends ConsumerWidget {
  const CustomRestoranButton({super.key, required this.pageController});
  final PageController
  pageController; // Sayfa kontrolcüsü, sayfalar arasında geçişi sağlar.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tema renk düzenini almak için kullanılan değişken
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Favori butonunun durumunu izliyoruz
    bool favoriteButtonState = ref.watch(favoriteButtonStateProvider);

    return TextButton(
      style: TextButton.styleFrom(
        // Butonun arka plan rengi, favori durumuna göre değişiyor
        backgroundColor:
            favoriteButtonState
                ? Colors
                    .transparent // Favori değilse şeffaf
                : colorScheme.primary.withValues(
                  alpha: 0.75,
                ), // Favori ise ana renk tonu
        shape: const RoundedRectangleBorder(
          // Butonun kenarlarını yuvarlatıyoruz
        ),
      ),
      onPressed: () {
        // Butona tıklandığında favori durumu 'false'ya ayarlanır ve sayfa geçişi yapılır
        ref.read(favoriteButtonStateProvider.notifier).state = false;
        pageController.animateToPage(
          0, // 0. sayfaya geçiş yapılır
          duration: const Duration(milliseconds: 300), // Geçiş süresi
          curve: Curves.easeIn, // Geçiş animasyonu
        );
      },
      child: Text(
        'food'.tr(), // Buton metni
        style: TextStyle(
          color:
              favoriteButtonState
                  ? colorScheme
                      .onSurface // Favori değilse metin rengi yüzeydeki metin rengi
                  : colorScheme
                      .onPrimary, // Favori ise metin rengi ana rengiyle uyumlu
          fontWeight: FontWeight.w600, // Yazı kalınlığı
        ),
      ),
    );
  }
}
