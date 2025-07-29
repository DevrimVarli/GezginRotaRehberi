import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:yeni_tasarim/model/hive/hive_registrar.g.dart';
import 'package:yeni_tasarim/model/kullanici_konum_freezed.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/intro_screen.dart';
import 'package:yeni_tasarim/theme/theme_palette.dart';

void main()async {
  Hive
     ..init(Directory.current.path)
     ..registerAdapters();
  await Hive.initFlutter();
  final box=await Hive.openBox<KullaniciKonumFreezed>('konumlar');
  WidgetsFlutterBinding.ensureInitialized(); // Flutter için gerekli hazırlık
  await Firebase.initializeApp();
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
          useMaterial3Typography: true,
        ),
      ),
      darkTheme: FlexThemeData.dark(
        colors: myDarkColors,
        subThemesData: const FlexSubThemesData(
          elevatedButtonRadius: 12,
          inputDecoratorRadius: 12,
          useMaterial3Typography: true,
        ),
      ),

      themeMode: ref.watch(themeModeProvider),
      home:const IntroEkran(),
    );
  }
}