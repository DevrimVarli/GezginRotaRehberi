import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yeni_tasarim/providers/all_providers.dart';
class CustomThemeChangeButton extends ConsumerWidget {
  const CustomThemeChangeButton({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ThemeMode themeMode = ref.watch(themeModeProvider);
    return  IconButton(
      icon: Icon(
        themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
        color: Theme.of(context).colorScheme.primary,
      ),
      onPressed: () {
        ThemeMode current = ref.read(themeModeProvider);
        ref.read(themeModeProvider.notifier).state =
        current == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
      },
    );
  }
}
