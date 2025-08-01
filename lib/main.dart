import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:yeni_tasarim/model/hive/hive_registrar.g.dart';
import 'package:yeni_tasarim/model/kullanici_konum_freezed.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/intro_screen.dart';
import 'package:yeni_tasarim/theme/theme_palette.dart';

void main() async {
  // Hive başlatma ve adaptörleri kaydetme
  Hive
    ..init(Directory.current.path)
    ..registerAdapters();

  // Flutter için Hive başlatma
  await Hive.initFlutter();

  // Kullanıcı konumları ve favoriler için Hive kutularını açma
  await Hive.openBox<KullaniciKonumFreezed>('konumlar');
  await Hive.openBox<String>('favoriler');

  // Flutter için gerekli ilk ayarlamalar
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase başlatma
  await Firebase.initializeApp();

  // Riverpod ProviderScope ile uygulamayı başlat
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      // Light tema
      theme: FlexThemeData.light(
        colors: myLightColors, // Light renk paleti
        subThemesData: const FlexSubThemesData(
          elevatedButtonRadius: 12, // Buton köşe yuvarlatma
          inputDecoratorRadius: 12, // Input köşe yuvarlatma
          useMaterial3Typography: true, // Material 3 tipografi
        ),
      ),

      // Dark tema
      darkTheme: FlexThemeData.dark(
        colors: myDarkColors, // Dark renk paleti
        subThemesData: const FlexSubThemesData(
          elevatedButtonRadius: 12,
          inputDecoratorRadius: 12,
          useMaterial3Typography: true,
        ),
      ),

      // Tema modu (Riverpod üzerinden yönetiliyor)
      themeMode: ref.watch(themeModeProvider),

      // İlk açılış ekranı
      home: const IntroEkran(),
    );
  }
}
