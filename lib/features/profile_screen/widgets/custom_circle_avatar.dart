import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';

class CustomCircleAvatar extends ConsumerWidget {
  const CustomCircleAvatar({super.key, this.firestoreData});

  final Map<String, dynamic>? firestoreData; // Firestore'dan gelen veriler

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Kullanıcının giriş yapıp yapmadığını kontrol ediyoruz
    bool girisNe = ref.read(authProvider).kullaniciyiBul();

    return CircleAvatar(
      radius: 90, // Avatarın yarıçapı (boyutu)
      backgroundColor: Colors.grey[300], // Arka plan rengi
      backgroundImage: girisNe
          ? (firestoreData!['profile_picture'] != null &&
          firestoreData!['profile_picture'].toString().isNotEmpty)
          ? NetworkImage(firestoreData!['profile_picture'].toString()) // Firestore'dan gelen URL varsa
          : const NetworkImage('https://example.com/default_image.jpg') // Varsayılan bir resim
          : NetworkImage(FirebaseAuth.instance.currentUser!.photoURL.toString()), // Firebase Authentication'dan gelen fotoğraf URL'si
    );
  }
}
