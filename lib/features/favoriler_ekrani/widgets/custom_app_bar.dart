import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppBar(
      title: Text(
        "Favoriler",
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w500,
          fontSize: 36,
          color: colorScheme.primary,
        ),
      ),
      centerTitle: true,
    );
  }
}
