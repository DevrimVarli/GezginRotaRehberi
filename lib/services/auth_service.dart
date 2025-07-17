import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yeni_tasarim/screens/see_all_screen.dart';
class AuthService {
  final Ref ref;
  AuthService(this.ref);

  // Kullanıcı kaydını gerçekleştiren fonksiyon
  Future<void> kayitEkle(
      BuildContext context, String kullaniciAdi, String mail, String password) async {
    try {
      // Kullanıcı adı, mail ve şifreyi alıyoruz
      UserCredential yetkiSonucu = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: password);

      String uidTutucu = yetkiSonucu.user!.uid;

      // Veritabanına kullanıcıyı ekliyoruz
      await FirebaseFirestore.instance.collection("Kullanicilar").doc(uidTutucu).set({
        "kullaniciAdi": kullaniciAdi,
        "email": mail,
      });

      // Kayıt işlemi başarılı, formu sıfırlıyoruz ve yeni sayfaya yönlendiriyoruz
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SeeAllEkrani()), // Hesabım sayfasına yönlendir
      );
    } on FirebaseAuthException catch (e) {
      // Hata mesajı
      Fluttertoast.showToast(msg: e.message ?? "Firebase hatası");
    }
  }

  // Kullanıcı girişi
  Future<void> girisYap(BuildContext context, String email, String password) async {
    try {
      // Giriş işlemi
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Giriş başarılı, formu sıfırlıyoruz ve yönlendiriyoruz
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SeeAllEkrani()),
      );
    } catch (hata) {
      // Hata mesajı
      Fluttertoast.showToast(msg: hata.toString());
    }
  }
}