import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:yeni_tasarim/providers/all_providers.dart';

class CustomOtelButton extends ConsumerWidget {

  const CustomOtelButton({super.key, required this.pageController});
  final PageController pageController; // Sayfa kontrolcüsü (pageController), sayfalar arasında geçiş yapmak için kullanılır.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tema renk düzenini almak için kullanılan değişken
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    // `favoriteButtonStateProvider` kullanılarak favori butonunun durumu izlenir
    bool favoriteButtonState = ref.watch(favoriteButtonStateProvider);

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: favoriteButtonState
            ? colorScheme.primary.withValues(alpha: 0.75) // Butonun arka plan rengi, favori ise daha opak bir renk
            : Colors.transparent, // Favori değilse şeffaf arka plan
        shape: const RoundedRectangleBorder(
          // Butonun şekli
        ),
      ),
      onPressed: () {
        // Butona tıklanıldığında favori durumu true'ya ayarlanır ve sayfa geçişi yapılır
        ref.read(favoriteButtonStateProvider.notifier).state = true;
        pageController.animateToPage(
          1, // 1. sayfaya geçiş
          duration: const Duration(milliseconds: 300), // Geçiş süresi
          curve: Curves.easeIn, // Geçişin eğrisi (yumuşak bir geçiş)
        );
      },
      child: Text(
        'Oteller', // Butonun metni
        style: TextStyle(
          color: favoriteButtonState
              ? colorScheme.onPrimary // Favori ise metin rengi ana temaya uygun
              : colorScheme.onSurface, // Favori değilse metin rengi yüzey temasıyla uyumlu
          fontWeight: FontWeight.w600, // Yazı kalınlığı
        ),
      ),
    );
  }
}
