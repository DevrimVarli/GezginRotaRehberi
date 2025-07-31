import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';

class CustomChoosePhoto extends ConsumerStatefulWidget {
  const CustomChoosePhoto({super.key});

  @override
  ConsumerState<CustomChoosePhoto> createState() => _CustomChoosePhotoState();
}

class _CustomChoosePhotoState extends ConsumerState<CustomChoosePhoto> {
  ImagePicker picker = ImagePicker();
  User user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
        onPressed: () {
          ref.read(authProvider).pickAndUploadProfilePicture(picker: picker, user: user);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child:  Text('Fotoğraf Seç', style:textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500) ),);
  }
}
