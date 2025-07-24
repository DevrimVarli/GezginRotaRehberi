import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/account_screen.dart';
import 'package:yeni_tasarim/screens/login_screen.dart';
class AccountAndLoginScreen extends ConsumerWidget {
  const AccountAndLoginScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    AsyncValue<User?> userAsync=ref.watch(userChangesProvider);
    return userAsync.when(
        data: (User? user){
          if(user!=null){
            return const AccountScreen();
          }else{
            return const LoginScreen();
          }
        },
        error: (Object error, StackTrace stackTrace)=>Center(child: Text(error.toString())),
        loading: ()=>const Center(child: CircularProgressIndicator()),);
  }
}
