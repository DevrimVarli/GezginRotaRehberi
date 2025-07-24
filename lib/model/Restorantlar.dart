import 'package:yeni_tasarim/model/Imkanlar.dart';
import 'package:yeni_tasarim/model/Konum.dart';

class Restorantlar {
  Restorantlar(
      this.restoran_id,
      this.restoran_ad,
      this.restoran_resim,
      this.restoran_puan,
      this.restoran_aciklama,
      this.restoran_fiyat,
      this.imkanlar,
      this.konum,
      );

  factory Restorantlar.fromJson(Map<String, dynamic> json) {
    return Restorantlar(
      json['restoran_id'] as int? ?? 0, // Null ise 0 kullan
      json['restoran_ad'] as String? ?? 'No Name', // Null için varsayılan değer
      json['restoran_resim'] as String? ?? '', // Eğer resim yoksa boş string
      json['restoran_puan'] as String? ?? 'No Rating', // Eğer puan yoksa varsayılan 'No Rating'
      json['restoran_aciklama'] as String? ?? 'No description', // Null için varsayılan açıklama
      json['restoran_fiyat'] as int? ?? 0, // Fiyat yoksa 0 döndür
      // Imkanlar listesine dönüşüm. Eğer 'imkanlar' null ise boş liste döndür
      (json['imkanlar'] as List<dynamic>?)
          ?.map((x) => Imkanlar.fromJson(x as Map<String, dynamic>))
          .toList() ?? <Imkanlar>[], // Eğer 'imkanlar' null ise boş liste döndür
      json['konum'] != null ? Konum.fromJson(json['konum'] as Map<String, dynamic>) : Konum('No City', 'No District'),
    );
  }

  int restoran_id;
  String restoran_ad;
  String restoran_resim;
  String restoran_puan;
  String restoran_aciklama;
  int restoran_fiyat;
  List<Imkanlar> imkanlar;
  Konum konum;
}
