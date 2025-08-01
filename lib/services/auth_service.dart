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

  /// Firebase Email-Password ile kayıt oluşturma
  Future<void> kayitEkle({
    required BuildContext context,
    required String mail,
    required String password,
    required String lastName,
    required String firstName,
    required String userName,
    required String phoneNumber,
  }) async {
    try {
      // E-posta ve şifre boşluk kontrolü
      if (mail.isEmpty || password.isEmpty) {
        await Fluttertoast.showToast(msg: 'E-posta ve şifre boş olamaz');
        return;
      }

      // Şifre uzunluk kontrolü
      if (password.length < 6) {
        await Fluttertoast.showToast(msg: 'Şifre en az 6 karakter olmalıdır');
        return;
      }

      // Firebase Authentication ile kayıt oluştur
      UserCredential yetkiSonucu = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: password);

      String uidTutucu = yetkiSonucu.user!.uid;

      // Firestore'a kullanıcı bilgilerini ekle
      await FirebaseFirestore.instance
          .collection('Kullanicilar1')
          .doc(uidTutucu)
          .set(<String, dynamic>{
        'email': mail,
        'lastName': lastName,
        'firstName': firstName,
        'userName': userName,
        'phoneNumber': phoneNumber,
      });

      // Başarılı olursa AccountScreen'e yönlendir
      if (!context.mounted) return;
      await Navigator.push(
        context,
        MaterialPageRoute<Widget>(
            builder: (BuildContext context) => const AccountScreen(),),
      );
    } on FirebaseAuthException catch (e) {
      // Firebase hata mesajı
      await Fluttertoast.showToast(msg: e.message ?? 'Firebase hatası');
    }
  }

  /// Firebase Email-Password ile giriş yapma
  Future<void> girisYap({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      // Email ve şifre boş kontrolü
      if (email.isEmpty || password.isEmpty) {
        await Fluttertoast.showToast(msg: 'Email veya şifre boş olamaz!');
        return;
      }

      // Firebase ile giriş yap
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (hata) {
      await Fluttertoast.showToast(msg: 'Kullanıcı bilgileri hatalı');
    }
  }

  /// Google ile giriş yapma
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Kullanıcı giriş iptali yaparsa
      if (googleUser == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Giriş iptal edildi')),
          );
        }
        return;
      }

      GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Başarılı giriş mesajı
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
              Text('Giriş başarılı: ${userCredential.user?.displayName}'),),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e')),
        );
      }
    }
  }

  /// Şifre değiştirme
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String? email = user?.email;

      if (user != null && email != null) {
        // Mevcut şifre ile tekrar giriş doğrulaması
        AuthCredential cred = EmailAuthProvider.credential(
            email: email, password: currentPassword,);
        await user.reauthenticateWithCredential(cred);

        // Yeni şifreyi ayarla
        await user.updatePassword(newPassword);
        await Fluttertoast.showToast(msg: 'Şifre başarıyla güncellendi.');
        await FirebaseAuth.instance.signOut();
        if (!context.mounted) return;
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<Widget>(
              builder: (BuildContext context) => const Secim(),),
              (Route<dynamic> route) => false,
        );
      } else {
        await Fluttertoast.showToast(msg: 'Kullanıcı oturumu bulunamadı.');
      }
    } catch (e) {
      await Fluttertoast.showToast(msg: 'Şifre değiştirme hatası: $e');
    }
  }

  /// E-posta değiştirme
  Future<void> changeEmail({
    required String currentPassword,
    required String newEmail,
    required BuildContext context,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String? oldEmail = user?.email;

      if (user != null && oldEmail != null) {
        // Mevcut şifre ile tekrar giriş doğrulaması
        AuthCredential cred = EmailAuthProvider.credential(
            email: oldEmail, password: currentPassword,);
        await user.reauthenticateWithCredential(cred);

        // Yeni e-posta için doğrulama gönder
        await user.verifyBeforeUpdateEmail(newEmail);
        await Fluttertoast.showToast(
            msg: 'E-posta doğrulama bağlantısı gönderildi.',);

        // Firestore e-posta güncelle
        await FirebaseFirestore.instance
            .collection('Kullanicilar1')
            .doc(user.uid)
            .update(<Object, Object?>{'email': newEmail});

        await FirebaseAuth.instance.signOut();
        if (!context.mounted) return;
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<Widget>(
              builder: (BuildContext context) => const Secim(),),
              (Route<dynamic> route) => false,
        );
      } else {
        await Fluttertoast.showToast(msg: 'Kullanıcı oturumu bulunamadı.');
      }
    } catch (e) {
      await Fluttertoast.showToast(msg: 'E-posta değiştirme hatası: $e');
    }
  }

  /// Hesap silme
  Future<void> deleteAccount(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String providerId = user.providerData.first.providerId;

        // Google ile giriş yaptıysa yeniden doğrulama
        if (providerId == 'google.com') {
          GoogleSignIn googleSignIn = GoogleSignIn();
          GoogleSignInAccount? googleUser = await googleSignIn.signIn();
          GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

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

        // Firebase Authentication'dan kullanıcı hesabını sil
        await user.delete();

        await Fluttertoast.showToast(msg: 'Hesap başarıyla silindi.');
        if (!context.mounted) return;
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<Widget>(
              builder: (BuildContext context) => const Secim(),),
              (Route<dynamic> route) => false,
        );
      } else {
        await Fluttertoast.showToast(msg: 'Kullanıcı bulunamadı.');
      }
    } catch (e) {
      await Fluttertoast.showToast(msg: 'Hesap silme hatası: $e');
    }
  }

  /// Profil fotoğrafı silme
  Future<void> photoDelete({required String imageUrl}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Firestore profil fotoğrafı alanını temizle
        await FirebaseFirestore.instance
            .collection('Kullanicilar1')
            .doc(user.uid)
            .update(<Object, Object?>{
          'profile_picture': FieldValue.delete(),
        });

        // Storage'dan fotoğrafı sil
        if (imageUrl.isNotEmpty) {
          Reference photoRef =
          FirebaseStorage.instance.refFromURL(imageUrl);
          await photoRef.delete();
        }

        await Fluttertoast.showToast(msg: 'Fotoğraf başarıyla silindi');
      }
    } catch (e) {
      await Fluttertoast.showToast(msg: 'Fotoğraf silme hatası: $e');
    }
  }

  /// Kullanıcı bilgilerini güncelleme
  Future<void> updateUserInfo({
    required String firstName,
    required String lastName,
    required String userName,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('Kullanicilar1')
            .doc(user.uid)
            .update(<Object, Object?>{
          'firstName': firstName,
          'lastName': lastName,
          'userName': userName,
        });

        // Firebase displayName güncelle
        await user.updateDisplayName('$firstName $lastName');

        await Fluttertoast.showToast(msg: 'Bilgiler güncellendi.');
      } else {
        await Fluttertoast.showToast(msg: 'Kullanıcı bulunamadı.');
      }
    } catch (e) {
      await Fluttertoast.showToast(msg: 'Güncelleme hatası: $e');
    }
  }

  /// Firestore kullanıcı verilerini çekme
  Future<Map<String, dynamic>?> getFirestoreUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> doc =
      await FirebaseFirestore.instance
          .collection('Kullanicilar1')
          .doc(user.uid)
          .get();
      return doc.data();
    }
    return null;
  }

  /// Profil fotoğrafı seçip yükleme
  Future<void> pickAndUploadProfilePicture({
    required ImagePicker picker,
    required User user,
  }) async {
    try {
      XFile? pickedFile =
      await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      File imageFile = File(pickedFile.path);
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Storage'a yükleme
      UploadTask uploadTask = FirebaseStorage.instance
          .ref('profile_pictures/$userId.jpg')
          .putFile(imageFile);

      ref.read(userPhotoProvider.notifier).state =
      await (await uploadTask).ref.getDownloadURL();

      // Firestore'a fotoğraf URL kaydı
      await FirebaseFirestore.instance
          .collection('Kullanicilar1')
          .doc(userId)
          .update(<Object, Object?>{
        'profile_picture': ref.watch(userPhotoProvider),
      });

      await Fluttertoast.showToast(msg: 'Fotoğraf başarıyla yüklendi');

      // Firebase profil fotoğrafı güncelle
      await user.updatePhotoURL(ref.watch(userPhotoProvider));
    } catch (e) {
      await Fluttertoast.showToast(
          msg: 'Fotoğraf yüklenirken hata oluştu: $e',);
    }
  }

  /// Kullanıcı giriş sağlayıcısını kontrol et
  bool kullaniciyiBul() {
    User user = FirebaseAuth.instance.currentUser!;
    for (UserInfo provider in user.providerData) {
      debugPrint('Giriş sağlayıcısı: ${provider.providerId}');

      if (provider.providerId == 'google.com') {
        return false; // Google ile giriş yapmış
      } else if (provider.providerId == 'password') {
        return true; // Email-Password ile giriş yapmış
      }
    }
    return false;
  }
}
