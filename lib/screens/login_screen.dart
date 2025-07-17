import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          Container(
            height:ekranYuksekligi ,
            width: ekranGenisligi,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/anaEkran.png"),fit: BoxFit.cover)
            ),
          ),
        Positioned(
            top: 93,
            left: 53,
            child: Text("Aspen",style: TextStyle(
              fontFamily: "Hiatus",
              color: Colors.white,
              fontSize: 150,
            ),)),
          Positioned(
            top: ekranYuksekligi/2,
            left: 53,
            right: 53,
            child: SizedBox(
              width:ekranGenisligi,
              height: 50,

              child: TextField(
                controller: sifreController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent.withValues(alpha: 0.58),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  labelText: "Şifre",
                  labelStyle: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color: Colors.white.withValues(alpha: 0.95)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.white,width: 1.75),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.white,width: 2.5),
                  )
              )),
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

                child: TextField(
                  controller: kullaniciAdiController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent.withValues(alpha: 0.58),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    labelText: "Kullanıcı Adı",
                    labelStyle: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color: Colors.white.withValues(alpha: 0.95)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.white,width: 1.75),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.white,width: 2.5),
                    )
                )),
              )),
          ),
          Positioned(
            top: ekranYuksekligi/2.35,
            left: 53,
            right: 53,
            child: SizedBox(
              width:ekranGenisligi,
              height: 50,

              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent.withValues(alpha: 0.58),
                  labelText: "Email",
                    labelStyle: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color: Colors.white.withValues(alpha: 0.95)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.white,width: 1.75),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.white,width: 2.5),
                    )
              )),
            )),
          Positioned(
            top: ekranYuksekligi/1.65,
            left: 53,
            right: 53,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.withValues(alpha: 0.65),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                  onPressed: (){
                  kayitMi?ref.read(authProvider).kayitEkle(context,kullaniciAdiController.text,emailController.text,sifreController.text):ref.read(authProvider).girisYap(context,emailController.text,sifreController.text);

                  },
                  child:kayitMi?Text("Kayıt Ol",style: TextStyle(color: Colors.white,fontSize: 18),): Text("Giriş Yap",style: TextStyle(color: Colors.white,fontSize: 18),))),
          Positioned(
            top: ekranYuksekligi/1.55,
            left: 53,
            right: 53,
              child: TextButton(onPressed: (){
                ref.read(kayitMiProvider.notifier).state=!kayitMi;
              }, child: kayitMi?Text("Mevcut hesabım bulunmakta",style: TextStyle(color: Colors.white,fontSize: 18),):Text("Şifreni mi unuttun?",style: TextStyle(color: Colors.white,fontSize: 18),))),


        ]
      ),
    );
  }
}
