import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Favoriler",
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w500,
          fontSize: 36,
          color: Colors.blue,
        ),
      ),
      centerTitle: true,
    );
  }
}
