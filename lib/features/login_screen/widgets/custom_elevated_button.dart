import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/all_providers.dart';
class CustomElevatedButton extends ConsumerWidget {
  final bool kayitMi;
  final TextEditingController sifreController;
  final TextEditingController kullaniciAdiController;
  final TextEditingController emailController;
  CustomElevatedButton({super.key,required this.kayitMi,required this.sifreController,required this.kullaniciAdiController,required this.emailController});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.withValues(alpha: 0.65),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: (){
          kayitMi?ref.read(authProvider).kayitEkle(context,kullaniciAdiController.text,emailController.text,sifreController.text):ref.read(authProvider).girisYap(context,emailController.text,sifreController.text);

        },
        child:kayitMi?Text("Kayıt Ol",style: TextStyle(color: Colors.white,fontSize: 18),): Text("Giriş Yap",style: TextStyle(color: Colors.white,fontSize: 18),));
  }
}
