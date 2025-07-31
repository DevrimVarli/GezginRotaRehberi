import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:yeni_tasarim/providers/all_providers.dart';

class AramaTextFieldWidget extends ConsumerWidget {
  const AramaTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: TextField(
        onChanged: (String aramaSonucu) {
          ref.read(aramaSonucuStateProvider.notifier).state = aramaSonucu;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: 32,
            color: colorScheme.outlineVariant, // ikon rengi
          ),
          labelStyle: TextStyle(
            fontSize: 22,
            color: colorScheme.primary, // tema ana rengi
            fontWeight: FontWeight.bold,
          ),
          hintText: 'Find things to do',
          hintStyle: GoogleFonts.roboto(
            fontSize: 22,
            color: colorScheme.outlineVariant,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.72), // zemin
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.transparent, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
              color: colorScheme.primary, // odak rengi tema ile uyumlu
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
