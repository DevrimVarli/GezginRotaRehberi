import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/intro_screen.dart';
import 'package:yeni_tasarim/theme/theme_palette.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter için gerekli hazırlık
  await Firebase.initializeApp(); // Firebase'i başlatıyoruz
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // main.dart içinde
      theme: FlexThemeData.light(
        colors: myLightColors,
        subThemesData: const FlexSubThemesData(
          elevatedButtonRadius: 12,
          inputDecoratorRadius: 12,
          useTextTheme: true,
        ),
      ),
      darkTheme: FlexThemeData.dark(
        colors: myDarkColors,
        subThemesData: const FlexSubThemesData(
          elevatedButtonRadius: 12,
          inputDecoratorRadius: 12,
          useTextTheme: true,
        ),
      ),

      themeMode: ref.watch(themeModeProvider),
      home:const IntroEkran(),
    );
  }
}