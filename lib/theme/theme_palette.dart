// light mode renkleri

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

final FlexSchemeColor myLightColors = FlexSchemeColor(
  primary: HexColor('#4682A9'), // Mavi
  primaryContainer: const Color(0xFF90CAF9), // Açık mavi arkaplan
  secondary: const Color(0xFF00ACC1), // Turkuaz
  secondaryContainer: const Color(0xFFB2EBF2),
  tertiary: Colors.green.shade500, // Ek renk
  tertiaryContainer: const Color(0xFFB2EBF2),
);

// dark mode renkleri
final FlexSchemeColor myDarkColors = FlexSchemeColor(
  primary: HexColor('#91C8E4'), // Koyu mavi
  primaryContainer: const Color(0xFF5472D3),
  secondary: const Color(0xFF00838F),
  secondaryContainer: const Color(0xFF4DD0E1),
  tertiary: const Color(0xFF006064),
  tertiaryContainer: const Color(0xFF4DD0E1),
);
