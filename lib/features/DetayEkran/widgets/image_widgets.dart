import 'package:yeni_tasarim/model/restorantlar.dart';
import 'package:yeni_tasarim/model/oteller.dart';
import 'package:flutter/material.dart';

class ImageWidgets extends StatelessWidget {
  const ImageWidgets({
    super.key,
    this.secilenOtel,
    this.secilenRestorant,
    required this.ekranGenisligi,
  });

  final Oteller? secilenOtel; // Seçilen otel
  final Restorantlar? secilenRestorant; // Seçilen restoran
  final double ekranGenisligi; // Ekran genişliği

  // OTEL VEYA RESTORANT RESMİ GÖSTERİLİYOR
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // Köşeleri yuvarlamak için ClipRRect widget'ını kullanıyoruz
      borderRadius: BorderRadius.circular(20), // 20 birimlik yuvarlak köşe
      child: SizedBox(
        width:
            ekranGenisligi, // Ekran genişliğine uyacak şekilde boyutlandırıyoruz
        height: 400, // Resmin yüksekliğini 400 sabit yapıyoruz
        child:
            secilenOtel != null
                ? Image.network(
                  secilenOtel!.otelResim, // Seçilen otelin resmini alıyoruz
                  fit: BoxFit.cover, // Resmin tüm alanı kaplamasını sağlıyoruz
                )
                : Image.network(
                  secilenRestorant!
                      .restoranResim, // Seçilen restoranın resmini alıyoruz
                  fit: BoxFit.cover, // Resmin tüm alanı kaplamasını sağlıyoruz
                ),
      ),
    );
  }
}
