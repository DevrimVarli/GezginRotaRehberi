import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../providers/all_providers.dart';

class CustomRestoranButton extends ConsumerWidget {
  final PageController pageController;

  CustomRestoranButton({super.key, required this.pageController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final favoriteButtonState = ref.watch(favoriteButtonStateProvider);

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: favoriteButtonState
            ? Colors.transparent
            : colorScheme.primary.withOpacity(0.75),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
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
        "Restoranlar",
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
