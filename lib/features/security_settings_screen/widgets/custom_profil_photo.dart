import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomProfilPhoto extends StatelessWidget {
  const CustomProfilPhoto({super.key, required this.user, required this.data});

  // Firebase kullanıcısı ve verilerini alır
  final User user; // Firebase'deki mevcut kullanıcı
  final Map<String, dynamic> data; // Kullanıcının verilerini içeren harita (Firestore'dan alınan veriler)

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60, // Avatarın yarıçapını (boyutunu) belirler
      backgroundImage: user.photoURL != null
          ? NetworkImage(user.photoURL!) // Eğer Firebase kullanıcısının fotoğraf URL'si varsa, onu gösterir
          : NetworkImage(data['profile_picture'].toString()), // Yoksa, Firestore'dan alınan profil resmini gösterir
    );
  }
}
