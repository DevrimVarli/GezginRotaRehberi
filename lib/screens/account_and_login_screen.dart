import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/account_screen.dart';
import 'package:yeni_tasarim/screens/login_screen.dart';

/// Kullanıcı giriş yapmışsa AccountScreen, yapmamışsa LoginScreen gösterir.
/// FirebaseAuth'un authStateChanges() akışını dinler.
class AccountAndLoginScreen extends ConsumerWidget {
  const AccountAndLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // userChangesProvider, FirebaseAuth.instance.authStateChanges() stream'ini dinliyor
    AsyncValue<User?> userAsync = ref.watch(userChangesProvider);

    return userAsync.when(
      /// Kullanıcı bilgisi başarıyla alındığında
      data: (User? user) {
        if (user != null) {
          // Kullanıcı giriş yapmış → Hesap ekranı
          return const AccountScreen();
        } else {
          // Kullanıcı giriş yapmamış → Giriş ekranı
          return const LoginScreen();
        }
      },

      /// Bir hata oluştuğunda ekrana hata mesajı yaz
      error: (Object error, StackTrace stackTrace) =>
          Center(child: Text(error.toString())),

      /// Veriler yüklenirken loading göstergesi
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
