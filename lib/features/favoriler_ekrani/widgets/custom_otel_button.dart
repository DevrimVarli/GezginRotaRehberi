import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../providers/all_providers.dart';

class CustomOtelButton extends ConsumerWidget {
  final PageController pageController;

  CustomOtelButton({super.key, required this.pageController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final favoriteButtonState = ref.watch(favoriteButtonStateProvider);

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: favoriteButtonState
            ? colorScheme.primary.withValues(alpha: 0.75)
            : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      onPressed: () {
        ref.read(favoriteButtonStateProvider.notifier).state = true;
        pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      },
      child: Text(
        "Oteller",
        style: TextStyle(
          color: favoriteButtonState
              ? colorScheme.onPrimary
              : colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
