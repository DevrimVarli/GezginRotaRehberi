import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/features/profile_screen/widgets/custom_divider.dart';
import 'package:yeni_tasarim/features/profile_screen/widgets/custom_info_tile.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ImagePicker picker = ImagePicker();
    User user = FirebaseAuth.instance.currentUser!;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
        ),
        title: Text(
          'Kullanıcı Bilgilerim',
          style: textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: ref.read(authProvider).kullaniciyiBul()?StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('Kullanicilar1')
            .doc(user.uid)
            .snapshots(), // Stream olarak verileri dinliyoruz
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Veri bulunamadı'));
          }

          Map<String, dynamic> firestoreData = snapshot.data!.data()!;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                // Profil fotoğrafı gösterimi
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 90,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:(firestoreData['profile_picture'] != null &&
                          firestoreData['profile_picture'].toString().isNotEmpty)
                          ? NetworkImage(firestoreData['profile_picture'].toString()) // Firestore'dan gelen URL varsa
                          : const NetworkImage('https://example.com/default_image.jpg'), // Varsayılan bir resim
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                          onPressed: () {
                            ref.read(authProvider).photoDelete(imageUrl:firestoreData['profile_picture'].toString().isNotEmpty? "${firestoreData['profile_picture']}":'' );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Fotoğraf seçme butonu
                ElevatedButton(
                  onPressed: () {
                    ref.read(authProvider).pickAndUploadProfilePicture(picker: picker, user: user);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Fotoğraf Seç', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      // Kullanıcı bilgilerini listelemek
                      InfoTile('Ad Soyad', user.displayName ?? "${firestoreData['firstName'] ?? ''} ${firestoreData['lastName'] ?? ''}"),
                      CustomDivider(),
                      InfoTile('Kullanıcı Adı', "${firestoreData['userName'] ?? "Yok"}"),
                      CustomDivider(),
                      InfoTile('E-posta',"${firestoreData['email'] ?? "E-posta Yok"}"),
                      CustomDivider(),
                      InfoTile('UID (Kullanıcı ID)', user.uid),
                      CustomDivider(),
                      InfoTile('Telefon Numarası', user.phoneNumber ?? "${firestoreData['phoneNumber'] ?? ''}"),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ): Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                // Profil fotoğrafı gösterimi
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 90,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:NetworkImage(user.photoURL.toString()),// Varsayılan bir resim
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Fotoğraf seçme butonu
                Text('Hoş Geldiniz',style: textTheme.headlineSmall),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      // Kullanıcı bilgilerini listelemek
                      InfoTile('Ad Soyad', user.displayName ?? ''),
                      CustomDivider(),
                      InfoTile('Kullanıcı Adı', user.displayName ?? 'Yok'),
                      CustomDivider(),
                      InfoTile('E-posta', user.email ?? 'E-posta yok'),
                      CustomDivider(),
                      InfoTile('UID (Kullanıcı ID)', user.uid),
                      CustomDivider(),
                      InfoTile('Telefon Numarası', user.phoneNumber ??  ''),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

}
