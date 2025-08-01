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
  ImagePicker picker = ImagePicker(); // Resim seçmek için kullanılan ImagePicker nesnesi
  User user = FirebaseAuth.instance.currentUser!; // Firebase'den şu anki kullanıcıyı alıyoruz

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme; // Temadaki metin stillerini alıyoruz
    return ElevatedButton(
      onPressed: () {
        // Butona tıklanıldığında, profil fotoğrafı seçmek ve yüklemek için pickAndUploadProfilePicture fonksiyonu çağrılır
        ref.read(authProvider).pickAndUploadProfilePicture(picker: picker, user: user);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12), // Butonun içindeki padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Butonun yuvarlatılmış köşeleri
        ),
      ),
      child: Text(
        'Fotoğraf Seç', // Buton metni
        style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500), // Buton metni için stil
      ),
    );
  }
}
