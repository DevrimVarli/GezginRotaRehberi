import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
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
    // Firebase üzerinden giriş yapmış kullanıcı bilgisi
    User user = FirebaseAuth.instance.currentUser!;

    // Tema renkleri ve yazı stilleri
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        // Geri tuşu
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
        ),
        title: Text('user_info'.tr(), style: textTheme.headlineSmall),
        centerTitle: true,
      ),

      // Kullanıcı Firestore üzerinde kayıtlı mı kontrol ediliyor
      body:
          ref.read(authProvider).kullaniciyiBul()
              ? StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                // Firestore'dan gerçek zamanlı olarak kullanıcı verilerini dinleme
                stream:
                    FirebaseFirestore.instance
                        .collection('Kullanicilar1')
                        .doc(user.uid)
                        .snapshots(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                  snapshot,
                ) {
                  // Veri yüklenirken loading göstergesi
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Veri yoksa veya kayıt bulunamadıysa
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Center(child: Text('Veri bulunamadı'));
                  }

                  // Firestore'dan gelen kullanıcı verileri
                  Map<String, dynamic> firestoreData = snapshot.data!.data()!;

                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      spacing: 16,
                      children: <Widget>[
                        // Profil fotoğrafı ve silme butonu
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            CustomCircleAvatar(firestoreData: firestoreData),
                            CustomDeleteButton(firestoreData: firestoreData),
                          ],
                        ),
                        // Fotoğraf seçme butonu
                        const CustomChoosePhoto(),

                        // Kullanıcı bilgilerini listeleme alanı
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              // Ad Soyad bilgisi
                              InfoTile(
                                'full_name'.tr(),
                                user.displayName ??
                                    "${firestoreData['firstName'] ?? ''} ${firestoreData['lastName'] ?? ''}",
                              ),
                              const CustomDivider(),

                              // Kullanıcı adı
                              InfoTile(
                                'user_name'.tr(),
                                "${firestoreData['userName'] ?? "Yok"}",
                              ),
                              const CustomDivider(),

                              // E-posta
                              InfoTile(
                                'email'.tr(),
                                "${firestoreData['email'] ?? "E-posta Yok"}",
                              ),
                              const CustomDivider(),

                              // UID
                              InfoTile('user_uid'.tr(), user.uid),
                              const CustomDivider(),

                              // Telefon numarası
                              InfoTile(
                                'phone_number'.tr(),
                                user.phoneNumber ??
                                    "${firestoreData['phoneNumber'] ?? ''}",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
              // Eğer Firestore üzerinde kullanıcı kaydı yoksa
              : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 16,
                  children: <Widget>[
                    // Profil fotoğrafı (varsayılan)
                    const Stack(
                      alignment: Alignment.center,
                      children: <Widget>[CustomCircleAvatar()],
                    ),

                    // Hoş geldiniz mesajı
                    Text('welcome'.tr(), style: textTheme.headlineSmall),

                    // Kullanıcı bilgilerini listeleme alanı
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          InfoTile('full_name'.tr(), user.displayName ?? ''),
                          const CustomDivider(),
                          InfoTile('user_name'.tr(), user.displayName ?? 'Yok'),
                          const CustomDivider(),
                          InfoTile('email'.tr(), user.email ?? 'E-posta yok'),
                          const CustomDivider(),
                          InfoTile('user_uid'.tr(), user.uid),
                          const CustomDivider(),
                          InfoTile('phone_number'.tr(), user.phoneNumber ?? ''),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
