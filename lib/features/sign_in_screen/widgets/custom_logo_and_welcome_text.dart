import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomLogoAndWelcomeText extends StatelessWidget {
  const CustomLogoAndWelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        Text(
          'LOGO',
          style: GoogleFonts.montserrat(
            fontSize: 64,
            fontWeight: FontWeight.bold,
            color: colorScheme.primary, // Tema mavisi
          ),
        ),
        SizedBox(height: ekranYuksekligi / 13),
        Text(
          'Welcome Back!',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Login to your account',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
