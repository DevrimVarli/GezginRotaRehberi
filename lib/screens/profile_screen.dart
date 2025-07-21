import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    double ekranGenisligi = MediaQuery.sizeOf(context).width;
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'Kullanıcı Bilgilerim',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              height: ekranYuksekligi,
              width: ekranGenisligi,
              child: Column(
                children: [
                  ListTile(
                    title: Text("Ad Soyad", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                    subtitle: Text(user.displayName ?? "Bilinmiyor"),
                  ),
                  _divider(ekranGenisligi),
                  ListTile(
                    title: Text("E-posta", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                    subtitle: Text(user.email ?? "E-posta yok"),
                  ),
                  _divider(ekranGenisligi),
                  ListTile(
                    title: Text("UID (Kullanıcı ID)", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                    subtitle: Text(user.uid),
                  ),
                  _divider(ekranGenisligi),
                  ListTile(
                    title: Text("Telefon Numarası", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                    subtitle: Text(user.phoneNumber ?? "Numara yok"),
                  ),
                  _divider(ekranGenisligi),
                  ListTile(
                    title: Text("Profil Fotoğrafı URL", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                    subtitle: Text(user.photoURL ?? "Yok"),
                  ),
                  _divider(ekranGenisligi),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider(double width) {
    return Container(
      width: width,
      height: 2,
      color: Colors.blue.shade100,
    );
  }
}
