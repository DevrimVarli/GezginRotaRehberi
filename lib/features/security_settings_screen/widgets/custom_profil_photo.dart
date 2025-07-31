import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomProfilPhoto extends StatelessWidget {
  const CustomProfilPhoto({super.key, required this.user, required this.data});
  final User user;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundImage: user.photoURL != null
          ? NetworkImage(user.photoURL!)
          :  NetworkImage(data['profile_picture'].toString()),
    );
  }
}
