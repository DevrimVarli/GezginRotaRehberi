import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:yeni_tasarim/providers/all_providers.dart';

class CustomRestoranButton extends ConsumerWidget {

  const CustomRestoranButton({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    bool favoriteButtonState = ref.watch(favoriteButtonStateProvider);

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: favoriteButtonState
            ? Colors.transparent
            : colorScheme.primary.withValues(alpha: 0.75),
        shape: const RoundedRectangleBorder(
          
        ),
      ),
      onPressed: () {
        ref.read(favoriteButtonStateProvider.notifier).state = false;
        pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      },
      child: Text(
        'Restoranlar',
        style: TextStyle(
          color: favoriteButtonState
              ? colorScheme.onSurface
              : colorScheme.onPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
