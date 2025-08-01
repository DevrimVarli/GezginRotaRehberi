import 'package:flutter/material.dart';

class ArkaPlanWidget extends StatelessWidget {

  // ARKA PLAN FOTOĞRAF
  const ArkaPlanWidget({super.key, required this.ekranYuksekligi, required this.ekranGenisligi, required this.resimYolu});

  final double ekranYuksekligi; // Ekranın yüksekliği
  final double ekranGenisligi; // Ekranın genişliği
  final String resimYolu; // Gösterilecek resmin yolu

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ekranYuksekligi, // Arka planın yüksekliği ekranın yüksekliğine göre ayarlanır
      width: ekranGenisligi, // Arka planın genişliği ekranın genişliğine göre ayarlanır
      child: Image(image: AssetImage(resimYolu), fit: BoxFit.fill), // Resmi AssetImage ile alıyoruz ve tüm alanı doldurması için fit: BoxFit.fill kullanıyoruz
    );
  }
}
