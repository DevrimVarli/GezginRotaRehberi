import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../providers/all_providers.dart';
import 'account_screen.dart';
import 'login_screen.dart';
class AccountAndLoginScreen extends ConsumerWidget {
  const AccountAndLoginScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final userAsync=ref.watch(userChangesProvider);
    return userAsync.when(
        data: (user){
          if(user!=null){
            return AccountScreen();
          }else{
            return LoginScreen();
          }
        },
        error: (error, stackTrace)=>Center(child: Text(error.toString())),
        loading: ()=>Center(child: CircularProgressIndicator()));
  }
}
