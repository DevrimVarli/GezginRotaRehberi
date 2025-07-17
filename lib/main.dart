import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/screens/intro_screen.dart';
import 'package:yeni_tasarim/theme/app_theme.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter için gerekli hazırlık
  await Firebase.initializeApp(); // Firebase'i başlatıyoruz
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home:IntroEkran(),
    );
  }
}

