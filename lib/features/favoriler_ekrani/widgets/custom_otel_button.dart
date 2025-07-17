import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../providers/all_providers.dart';
class CustomOtelButton extends ConsumerWidget {
  PageController pageController;
  CustomOtelButton({super.key, required this.pageController});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final favoriteButtonState = ref.watch(favoriteButtonStateProvider);
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: favoriteButtonState
            ? Colors.blue.withOpacity(0.75)
            : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      onPressed: () {
        ref.read(favoriteButtonStateProvider.notifier).state = true; // Oteller butonuna basıldığında, otelleri göster
        pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeIn); // Sayfa 2'ye git
      },
      child: Text(
        "Oteller",
        style: TextStyle(color: favoriteButtonState ? Colors.white : Colors.black),
      ),
    );
  }
}
