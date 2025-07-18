import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/features/login_screen/widgets/custom_elevated_button.dart';
import 'package:yeni_tasarim/features/login_screen/widgets/custom_text_field.dart';

import '../features/login_screen/widgets/custom_image_card.dart';
import '../features/login_screen/widgets/custom_text_button.dart';
import '../features/login_screen/widgets/custom_title.dart';
import '../providers/all_providers.dart';
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final kayitMi=ref.watch(kayitMiProvider);
    double ekranGenisligi = MediaQuery.sizeOf(context).width;
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;
    final TextEditingController sifreController = TextEditingController();
    final TextEditingController kullaniciAdiController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    return SafeArea(
      child: Stack(
        children:[
          CustomImageCard(),
          CustomTitle(),

          Positioned(
            top: ekranYuksekligi/2,
            left: 53,
            right: 53,
            child: SizedBox(
              width:ekranGenisligi,
              height: 50,

              child: CustomTextField(controller: sifreController, label: "Şifre")
            )),
          Visibility(
            visible: kayitMi?true:false,
            child: Positioned(
              top: ekranYuksekligi/2.80,
              left: 53,
              right: 53,
              child: SizedBox(
                width:ekranGenisligi,
                height: 50,

                child: CustomTextField(controller: kullaniciAdiController, label: "Kullanıcı Adı"),
              )),
          ),
          Positioned(
            top: ekranYuksekligi/2.35,
            left: 53,
            right: 53,
            child: SizedBox(
              width:ekranGenisligi,
              height: 50,

              child: CustomTextField(controller: emailController, label: "Email"),
            )),
          Positioned(
            top: ekranYuksekligi/1.65,
            left: 53,
            right: 53,
              child:CustomElevatedButton(kayitMi: kayitMi, sifreController: sifreController, kullaniciAdiController: kullaniciAdiController, emailController: emailController) ),
          Positioned(
            top: ekranYuksekligi/1.55,
            left: 53,
            right: 53,
              child: CustomTextButton(kayitMi: kayitMi)),


        ]
      ),
    );
  }
}
