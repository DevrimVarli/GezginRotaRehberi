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

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          'Kullanıcı Bilgilerim',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              height: ekranYuksekligi,
              width: ekranGenisligi,
              child: ListView(
                children: [
                  _infoTile("Ad Soyad", user.displayName ?? "${firestoreData?['firstName'] ?? ''} ${firestoreData?['lastName'] ?? ''}"),
                  _divider(ekranGenisligi),
                  _infoTile("Kullanıcı Adı", firestoreData?['userName'] ?? "Yok"),
                  _divider(ekranGenisligi),
                  _infoTile("E-posta", user.email ?? "E-posta yok"),
                  _divider(ekranGenisligi),
                  _infoTile("UID (Kullanıcı ID)", user.uid),
                  _divider(ekranGenisligi),
                  _infoTile("Telefon Numarası", user.phoneNumber ?? "${firestoreData?['phoneNumber'] ?? ''}"),
                  _divider(ekranGenisligi),
                  _infoTile("Profil Fotoğrafı URL", user.photoURL ?? "Yok"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _divider(double width) {
    return Container(
      width: width,
      height: 1.5,
      color: Colors.blue.shade100,
    );
  }

  Widget _infoTile(String title, String value) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      subtitle: Text(value.isNotEmpty ? value : "Bilinmiyor"),
    );
  }
}
