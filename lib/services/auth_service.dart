import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/account_screen.dart';
import 'package:yeni_tasarim/screens/bottom_navigation_bar_screen.dart';
class AuthService {
  AuthService(this.ref);
  final Ref ref;

  Future<void> kayitEkle(
  {required BuildContext context,required String mail,required String password,required String lastName,required String firstName,required String userName,required String phoneNumber,}) async {
    try {
      UserCredential yetkiSonucu = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: password);

      String uidTutucu = yetkiSonucu.user!.uid;

      await FirebaseFirestore.instance.collection('Kullanicilar1').doc(uidTutucu).set(<String,dynamic >{
        'email': mail,
        'lastName':lastName,
        'firstName':firstName,
        'userName':userName,
        'phoneNumber':phoneNumber,
      });
      if (!context.mounted) return;
      await Navigator.push(
        context, MaterialPageRoute<Widget>(builder: (BuildContext context) => const AccountScreen()),
      );
    } on FirebaseAuthException catch (e) {
      // Hata mesajı
      await Fluttertoast.showToast(msg: e.message ?? 'Firebase hatası');
    }
  }

  Future<void> girisYap({required BuildContext context,required String email,required String password}) async {
    try {
      UserCredential _ = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);


    } catch (hata) {
      await Fluttertoast.showToast(msg:'Kullanıcı bilgileri hatalı');
    }
  }
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Google giriş nesnesini oluştur (Google hesabı seçtirir)
      GoogleSignIn googleSignIn = GoogleSignIn();

      // Kullanıcıdan Google hesabı seçmesini iste
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Eğer kullanıcı hesabı seçmeden pencereyi kapatırsa, giriş iptal edilmiş olur
      if (googleUser == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Giriş iptal edildi')),
          );
        }
        return; // Fonksiyonu durdur
      }

      // Seçilen Google hesabından kimlik bilgilerini (token) al
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Bu kimlik bilgilerini Firebase'in anlayacağı formata çevir (credential)
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase'e bu credential ile giriş yap
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Giriş başarılıysa kullanıcıya bilgi mesajı göster
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Giriş başarılı: ${userCredential.user?.displayName}')),
        );

      }

    } catch (e) {
      // Eğer bir hata olursa, bunu kullanıcıya göster
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e')),
        );
      }
    }
  }
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String? email = user?.email;

      if (user != null && email != null) {
        // Eski şifreyle yeniden kimlik doğrulama
        AuthCredential cred = EmailAuthProvider.credential(email: email, password: currentPassword);
        await user.reauthenticateWithCredential(cred);

        // Yeni şifreyi ayarla
        await user.updatePassword(newPassword);
        await Fluttertoast.showToast(msg: 'Şifre başarıyla güncellendi.');
        await FirebaseAuth.instance.signOut();
        if (!context.mounted) return;
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<Widget>(builder: (BuildContext context) => const Secim()),
              (Route<dynamic> route) => false,
        );
      } else {
        await Fluttertoast.showToast(msg: 'Kullanıcı oturumu bulunamadı.');
      }
    } catch (e) {
      await Fluttertoast.showToast(msg: 'Şifre değiştirme hatası: $e');
    }
  }
  Future<void> changeEmail({
    required String currentPassword,
    required String newEmail,
    required BuildContext context,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String? oldEmail = user?.email;

      if (user != null && oldEmail != null) {
        // Eski şifreyle yeniden kimlik doğrulama
        AuthCredential cred = EmailAuthProvider.credential(email: oldEmail, password: currentPassword);
        await user.reauthenticateWithCredential(cred);

        // E-posta adresini güncelle
        await user.verifyBeforeUpdateEmail(newEmail);
        await Fluttertoast.showToast(msg: 'E-posta doğrulama bağlantısı gönderildi.');
        // Firestore'daki email bilgisini de güncelle
        await FirebaseFirestore.instance
            .collection('Kullanicilar1')
            .doc(user.uid)
            .update(<Object, Object?>{'email': newEmail});
        await FirebaseAuth.instance.signOut();
        if (!context.mounted) return;
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<Widget>(builder: (BuildContext context) => const Secim()),
              (Route<dynamic> route) => false,
        );

      } else {
        await Fluttertoast.showToast(msg: 'Kullanıcı oturumu bulunamadı.');
      }
    } catch (e) {
      await Fluttertoast.showToast(msg: 'E-posta değiştirme hatası: $e');
    }
  }


  Future<void> deleteAccount(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Kullanıcının giriş sağlayıcısını kontrol et
        String providerId = user.providerData.first.providerId;

        // Reauthentication işlemi (Google ise özel yapılmalı)
        if (providerId == 'google.com') {
           GoogleSignIn googleSignIn = GoogleSignIn();
          GoogleSignInAccount? googleUser = await googleSignIn.signIn();
          GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

          OAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );

          await user.reauthenticateWithCredential(credential);
        }

        // Firestore'dan kullanıcı verisini sil
        await FirebaseFirestore.instance
            .collection('Kullanicilar1')
            .doc(user.uid)
            .delete();

        // Firebase Authentication'dan hesabı sil
        await user.delete();

        await Fluttertoast.showToast(msg: 'Hesap başarıyla silindi.');
        if (!context.mounted) return;
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<Widget>(builder: (BuildContext context) => const Secim()),
              (Route<dynamic> route) => false,
        );
      } else {
        await Fluttertoast.showToast(msg: 'Kullanıcı bulunamadı.');
      }
    } catch (e) {
      await Fluttertoast.showToast(msg: 'Hesap silme hatası: $e');
    }
  }

  Future<void> photoDelete({
    required String imageUrl, // Fotoğrafın URL'sini alıyoruz
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Firestore'dan profil fotoğrafı alanını silme
        await FirebaseFirestore.instance.collection('Kullanicilar1')
            .doc(user.uid)
            .update(<Object, Object?>{
          'profile_picture': FieldValue.delete(),
        });

        // Firebase Storage'dan fotoğrafı silme (eğer imageUrl varsa)
        if (imageUrl.isNotEmpty) {
          Reference photoRef = FirebaseStorage.instance.refFromURL(imageUrl);
          await photoRef.delete();
        }

         await Fluttertoast.showToast(msg: 'Fotoğraf başarıyla silindi');
      }
    } catch (e) {
      // Hata mesajını detaylı şekilde yazdırma
       await Fluttertoast.showToast(msg: 'Fotoğraf silme hatası: $e');
    }
  }
  Future<void> updateUserInfo({
    required String firstName,
    required String lastName,
    required String userName,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Firestore'daki kullanıcı bilgilerini güncelle
        await FirebaseFirestore.instance
            .collection('Kullanicilar1')
            .doc(user.uid)
            .update(<Object, Object?>{
          'firstName': firstName,
          'lastName': lastName,
          'userName': userName,
        });

        // Firebase displayName güncelle (isteğe bağlı)
        await user.updateDisplayName('$firstName $lastName');

        await Fluttertoast.showToast(msg: 'Bilgiler güncellendi.');
      } else {
        await Fluttertoast.showToast(msg: 'Kullanıcı bulunamadı.');
      }
    } catch (e) {
      await Fluttertoast.showToast(msg: 'Güncelleme hatası: $e');
    }
  }
  Future<Map<String, dynamic>?> getFirestoreUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance
          .collection('Kullanicilar1')
          .doc(user.uid)
          .get();
      return doc.data();
    }
    return null;
  }
  Future<void> pickAndUploadProfilePicture({required ImagePicker picker,required User user}) async {
    try {
      // Fotoğrafı seçmek için galeriye erişim
      XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return; // Eğer kullanıcı fotoğraf seçmezse işlemi sonlandır

      File imageFile = File(pickedFile.path);



      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Fotoğrafı Firebase Storage'a yükleme
      UploadTask uploadTask = FirebaseStorage.instance
          .ref('profile_pictures/$userId.jpg') // Kullanıcıya özel yedekleme
          .putFile(imageFile);

      // Yükleme tamamlandıktan sonra URL'yi al
      ref.read(userPhotoProvider.notifier).state = await (await uploadTask).ref.getDownloadURL();

      // Fotoğraf URL'sini Firestore'a kaydedin
      await FirebaseFirestore.instance.collection('Kullanicilar1').doc(userId).update(<Object, Object?>{
        'profile_picture': ref.watch(userPhotoProvider),
      });

       await Fluttertoast.showToast(msg: 'Fotoğraf başarıyla yüklendi');

      // Yükleme tamamlandığında, fotoğrafı ekranda güncelle
      await user.updatePhotoURL(ref.watch(userPhotoProvider)); // Kullanıcı fotoğrafını güncelle
    } catch (e) {
       await Fluttertoast.showToast(msg: 'Fotoğraf yüklenirken hata oluştu: $e');
    }
  }

  bool kullaniciyiBul(){
    User user = FirebaseAuth.instance.currentUser!;
    for (UserInfo provider in user.providerData) {
      debugPrint('Giriş sağlayıcısı: ${provider.providerId}');

      if (provider.providerId == 'google.com') {
        return false;
      } else if (provider.providerId == 'password') {
        return true;
      }
    }
      return false;

  }

}
