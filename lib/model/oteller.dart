import 'package:yeni_tasarim/model/Imkanlar.dart';

class Oteller {
  int otel_id;
  String otel_ad;
  String otel_resim;
  int otel_yildiz;
  String otel_aciklama;
  int otel_fiyat;
  List<Imkanlar> imkanlar;


  // Constructor
  Oteller(
      this.otel_id,
      this.otel_ad,
      this.otel_resim,
      this.otel_yildiz,
      this.otel_aciklama,
      this.otel_fiyat,
      this.imkanlar

      );

  // factory constructor with JSON
  factory Oteller.fromJson(Map<String, dynamic> json) {
    return Oteller(
      json["otel_id"] as int,
      json["otel_ad"] as String,
      json["otel_resim"] as String,
      json["otel_yildiz"] as int,
      json["otel_aciklama"] as String,
      json["otel_fiyat"] as int,
      List<Imkanlar>.from(json["imkanlar"].map((x) => Imkanlar.fromJson(x))),

    );
  }
}
