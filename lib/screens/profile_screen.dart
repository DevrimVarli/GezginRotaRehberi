import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/features/profile_screen/widgets/custom_choose_photo.dart';
import 'package:yeni_tasarim/features/profile_screen/widgets/custom_circle_avatar.dart';
import 'package:yeni_tasarim/features/profile_screen/widgets/custom_delete_button.dart';
import 'package:yeni_tasarim/features/profile_screen/widgets/custom_divider.dart';
import 'package:yeni_tasarim/features/profile_screen/widgets/custom_info_tile.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';


class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              spacing: 16,
              children: <Widget>[
                // Profil fotoğrafı gösterimi
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CustomCircleAvatar(firestoreData: firestoreData),
                    CustomDeleteButton(firestoreData: firestoreData),
                  ],
                ),
                // Fotoğraf seçme butonu
               const CustomChoosePhoto(),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      // Kullanıcı bilgilerini listelemek
                      InfoTile('Ad Soyad', user.displayName ?? "${firestoreData['firstName'] ?? ''} ${firestoreData['lastName'] ?? ''}"),
                      const CustomDivider(),
                      InfoTile('Kullanıcı Adı', "${firestoreData['userName'] ?? "Yok"}"),
                      const CustomDivider(),
                      InfoTile('E-posta',"${firestoreData['email'] ?? "E-posta Yok"}"),
                      const CustomDivider(),
                      InfoTile('UID (Kullanıcı ID)', user.uid),
                      const CustomDivider(),
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
              spacing: 16,
              children: <Widget>[
                // Profil fotoğrafı gösterimi
                const Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CustomCircleAvatar(),
                  ],
                ),
                // Fotoğraf seçme butonu
                Text('Hoş Geldiniz',style: textTheme.headlineSmall),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      // Kullanıcı bilgilerini listelemek
                      InfoTile('Ad Soyad', user.displayName ?? ''),
                      const CustomDivider(),
                      InfoTile('Kullanıcı Adı', user.displayName ?? 'Yok'),
                      const CustomDivider(),
                      InfoTile('E-posta', user.email ?? 'E-posta yok'),
                      const CustomDivider(),
                      InfoTile('UID (Kullanıcı ID)', user.uid),
                      const CustomDivider(),
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
