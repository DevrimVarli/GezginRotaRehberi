import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../providers/all_providers.dart';
class CustomRestoranButton extends ConsumerWidget {
  PageController pageController;
  CustomRestoranButton({super.key, required this.pageController});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final favoriteButtonState = ref.watch(favoriteButtonStateProvider);
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: favoriteButtonState
            ? Colors.transparent
            : Colors.blue.withOpacity(0.75),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      onPressed: () {
        ref.read(favoriteButtonStateProvider.notifier).state = false; // Restoranlar butonuna basıldığında, restoranları göster
        pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeIn); // Sayfa 1'e git
      },
      child: Text(
        "Restoranlar",
        style: TextStyle(color: favoriteButtonState ? Colors.black : Colors.white),
      ),
    );
  }
}
