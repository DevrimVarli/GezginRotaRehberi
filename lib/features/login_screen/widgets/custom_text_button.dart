import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/all_providers.dart';
class CustomTextButton extends ConsumerWidget {
  bool kayitMi;
   CustomTextButton({super.key,required this.kayitMi});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return TextButton(onPressed: (){
      ref.read(kayitMiProvider.notifier).state=!kayitMi;
    }, child: kayitMi?Text("Mevcut hesabım bulunmakta",style: TextStyle(color: Colors.white,fontSize: 18),):Text("Şifreni mi unuttun?",style: TextStyle(color: Colors.white,fontSize: 18),));
  }
}
