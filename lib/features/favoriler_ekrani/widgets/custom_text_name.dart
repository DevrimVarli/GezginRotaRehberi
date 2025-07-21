import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextName extends StatelessWidget {
  final String mekan_ad;

  const CustomTextName({super.key, required this.mekan_ad});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Positioned(
      top: 10,
      left: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withOpacity(0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            mekan_ad,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
