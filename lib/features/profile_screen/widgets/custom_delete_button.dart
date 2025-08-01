import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';

class CustomDeleteButton extends ConsumerWidget {
  const CustomDeleteButton({super.key, required this.firestoreData});

  final Map<String, dynamic> firestoreData; // Firestore'dan gelen veri

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      bottom: 0, // Ekranın alt kısmından 0 birim uzaklıkta
      right: 0, // Ekranın sağ kısmından 0 birim uzaklıkta
      child: CircleAvatar(
        radius: 25, // Butonun yarıçapı (boyutu)
        backgroundColor: Colors.white, // Arka plan rengi beyaz
        child: IconButton(
          icon: const Icon(Icons.delete, size: 20, color: Colors.red), // Silme ikonu, kırmızı renk
          onPressed: () {
            // Butona tıklanıldığında, fotoğrafı silme işlemi yapılır
            ref.read(authProvider).photoDelete(
                imageUrl: firestoreData['profile_picture'].toString().isNotEmpty
                    ? "${firestoreData['profile_picture']}" // Eğer fotoğraf URL'si varsa
                    : '' // Yoksa boş string gönder
            ,);
          },
        ),
      ),
    );
  }
}
