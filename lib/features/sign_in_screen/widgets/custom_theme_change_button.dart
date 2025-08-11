import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';

class CustomThemeChangeButton extends ConsumerWidget {
  const CustomThemeChangeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tema modunu izler
    ThemeMode themeMode = ref.watch(themeModeProvider);

    return IconButton(
      // Tema moduna göre ikon değişir
      icon: Icon(
        themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
        color:
            Theme.of(
              context,
            ).colorScheme.primary, // İkonun rengi, tema ile uyumlu
      ),
      onPressed: () {
        // Mevcut tema modunu alır ve tersine çevirir
        ThemeMode current = ref.read(themeModeProvider);
        ref.read(themeModeProvider.notifier).state =
            current == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
      },
    );
  }
}
