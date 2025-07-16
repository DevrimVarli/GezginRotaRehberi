import 'Imkanlar.dart';
import 'Konum.dart';

class Restorantlar {
  int restoran_id;
  String restoran_ad;
  String restoran_resim;
  String restoran_puan;
  String restoran_aciklama;
  int restoran_fiyat;
  List<Imkanlar> imkanlar;
  Konum konum;

  Restorantlar(
      this.restoran_id,
      this.restoran_ad,
      this.restoran_resim,
      this.restoran_puan,
      this.restoran_aciklama,
      this.restoran_fiyat,
      this.imkanlar, this.konum,
      );

  factory Restorantlar.fromJson(Map<String, dynamic> json) {
    return Restorantlar(
      json["restoran_id"] as int? ?? 0, // Eğer null ise 0 kullan
      json["restoran_ad"] as String? ?? 'No Name', // Null için varsayılan değer
      json["restoran_resim"] as String? ?? '',
      json["restoran_puan"] as String? ?? 'No Rating',
      json["restoran_aciklama"] as String? ?? 'No description',
      json["restoran_fiyat"] as int? ?? 0,
      List<Imkanlar>.from(json["imkanlar"].map((x) => Imkanlar.fromJson(x))),
      Konum.fromJson(json["konum"]),
    );
  }
}