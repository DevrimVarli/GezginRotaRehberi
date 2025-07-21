import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_android/google_sign_in_android.dart';

import 'package:yeni_tasarim/screens/account_screen.dart';
import 'package:yeni_tasarim/screens/see_all_screen.dart';
class AuthService {
  final Ref ref;
  AuthService(this.ref);

  Future<void> kayitEkle(
  {required BuildContext context,required String mail,required String password,required String lastName,required String firstName,required String userName}) async {
    try {
      UserCredential yetkiSonucu = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: password);

      String uidTutucu = yetkiSonucu.user!.uid;

      await FirebaseFirestore.instance.collection("Kullanicilar1").doc(uidTutucu).set({
        "email": mail,
        "lastName":lastName,
        "firstName":firstName,
        "userName":userName
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AccountScreen()),
      );
    } on FirebaseAuthException catch (e) {
      // Hata mesajı
      Fluttertoast.showToast(msg: e.message ?? "Firebase hatası");
    }
  }

  Future<void> girisYap(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AccountScreen()),
      );
    } catch (hata) {
      Fluttertoast.showToast(msg:"Kullanıcı bilgileri hatalı");
    }
  }
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Google giriş nesnesini oluştur (Google hesabı seçtirir)
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Kullanıcıdan Google hesabı seçmesini iste
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Eğer kullanıcı hesabı seçmeden pencereyi kapatırsa, giriş iptal edilmiş olur
      if (googleUser == null) {
        // Kullanıcı iptal ettiğinde ekrana uyarı göster
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Giriş iptal edildi')),
        );
        return; // Fonksiyonu durdur
      }

      // Seçilen Google hesabından kimlik bilgilerini (token) al
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Bu kimlik bilgilerini Firebase'in anlayacağı formata çevir (credential)
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase'e bu credential ile giriş yap
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Giriş başarılıysa kullanıcıya bilgi mesajı göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Giriş başarılı: ${userCredential.user?.displayName}')),
      );

    } catch (e) {
      // Eğer bir hata olursa, bunu kullanıcıya göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }






}