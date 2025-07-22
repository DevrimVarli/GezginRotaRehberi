import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final ekranGenisligi = MediaQuery.sizeOf(context).width;
    final ekranYuksekligi = MediaQuery.sizeOf(context).height;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon:  Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
        ),
        title:  Text(
          'Kullanıcı Bilgilerim',
          style: textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getFirestoreUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final firestoreData = snapshot.data;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: user.photoURL != null
                      ? NetworkImage(user.photoURL!)
                      : const NetworkImage("https://sunnysmilesep.com/wp-content/uploads/2019/05/AdobeStock_214746128-1024x683.jpeg"),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: [

                      InfoTile("Ad Soyad", user.displayName ?? "${firestoreData?['firstName'] ?? ''} ${firestoreData?['lastName'] ?? ''}"),
                    Container(
                      width: ekranGenisligi,
                      height: 1.5,
                      color: colorScheme.onSurface,
                    ),
                      InfoTile("Kullanıcı Adı", firestoreData?['userName'] ?? "Yok"),
                      Container(
                        width: ekranGenisligi,
                        height: 1.5,
                        color: colorScheme.onSurface,
                      ),
                      InfoTile("E-posta", user.email ?? "E-posta yok"),
                      Container(
                        width: ekranGenisligi,
                        height: 1.5,
                        color: colorScheme.onSurface,
                      ),
                      InfoTile("UID (Kullanıcı ID)", user.uid),
                      Container(
                        width: ekranGenisligi,
                        height: 1.5,
                        color: colorScheme.onSurface,
                      ),
                      InfoTile("Telefon Numarası", user.phoneNumber ?? "${firestoreData?['phoneNumber'] ?? ''}"),

                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }



}

class InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const InfoTile(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.onSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.labelLarge?.copyWith(
              color: colorScheme.surface,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.isNotEmpty ? value : "Bilinmiyor",
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.surface.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}


