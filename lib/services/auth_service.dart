import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yeni_tasarim/screens/account_screen.dart';
import 'package:yeni_tasarim/screens/bottom_navigation_bar_screen.dart';
class AuthService {
  final Ref ref;
  AuthService(this.ref);

  Future<void> kayitEkle(
  {required BuildContext context,required String mail,required String password,required String lastName,required String firstName,required String userName,required String phoneNumber}) async {
    try {
      UserCredential yetkiSonucu = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: password);

      String uidTutucu = yetkiSonucu.user!.uid;

      await FirebaseFirestore.instance.collection("Kullanicilar1").doc(uidTutucu).set({
        "email": mail,
        "lastName":lastName,
        "firstName":firstName,
        "userName":userName,
        "phoneNumber":phoneNumber
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
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final email = user?.email;

      if (user != null && email != null) {
        // Eski şifreyle yeniden kimlik doğrulama
        final cred = EmailAuthProvider.credential(email: email, password: currentPassword);
        await user.reauthenticateWithCredential(cred);

        // Yeni şifreyi ayarla
        await user.updatePassword(newPassword);
        Fluttertoast.showToast(msg: "Şifre başarıyla güncellendi.");
      } else {
        Fluttertoast.showToast(msg: "Kullanıcı oturumu bulunamadı.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Şifre değiştirme hatası: $e");
    }
  }
  Future<void> changeEmail({
    required String currentPassword,
    required String newEmail,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final oldEmail = user?.email;

      if (user != null && oldEmail != null) {
        // Eski şifreyle yeniden kimlik doğrulama
        final cred = EmailAuthProvider.credential(email: oldEmail, password: currentPassword);
        await user.reauthenticateWithCredential(cred);

        // E-posta adresini güncelle
        await user.verifyBeforeUpdateEmail(newEmail);
        Fluttertoast.showToast(msg: "E-posta doğrulama bağlantısı gönderildi.");
        // Firestore'daki email bilgisini de güncelle
        await FirebaseFirestore.instance
            .collection("Kullanicilar1")
            .doc(user.uid)
            .update({"email": newEmail});

      } else {
        Fluttertoast.showToast(msg: "Kullanıcı oturumu bulunamadı.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "E-posta değiştirme hatası: $e");
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Firestore'dan kullanıcı verisini sil
        await FirebaseFirestore.instance
            .collection("Kullanicilar1")
            .doc(user.uid)
            .delete();

        // Firebase Authentication'dan hesabı sil
        await user.delete();

        Fluttertoast.showToast(msg: "Hesap başarıyla silindi.");
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Secim()), (route) => false);

      } else {
        Fluttertoast.showToast(msg: "Kullanıcı bulunamadı.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Hesap silme hatası: $e");
    }
  }
  Future<void> updateUserInfo({
    required String firstName,
    required String lastName,
    required String userName,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Firestore'daki kullanıcı bilgilerini güncelle
        await FirebaseFirestore.instance
            .collection("Kullanicilar1")
            .doc(user.uid)
            .update({
          "firstName": firstName,
          "lastName": lastName,
          "userName": userName,
        });

        // Firebase displayName güncelle (isteğe bağlı)
        await user.updateDisplayName("$firstName $lastName");

        Fluttertoast.showToast(msg: "Bilgiler güncellendi.");
      } else {
        Fluttertoast.showToast(msg: "Kullanıcı bulunamadı.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Güncelleme hatası: $e");
    }
  }
  Future<Map<String, dynamic>?> getFirestoreUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection("Kullanicilar1")
          .doc(user.uid)
          .get();
      return doc.data();
    }
    return null;
  }










}