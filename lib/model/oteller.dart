import 'package:yeni_tasarim/model/Imkanlar.dart';
import 'package:yeni_tasarim/model/Konum.dart';

class Oteller {
  // Constructor
  Oteller(
      this.otel_id,
      this.otel_ad,
      this.otel_resim,
      this.otel_yildiz,
      this.otel_aciklama,
      this.otel_fiyat,
      this.imkanlar,
      this.konum,
      );

  // factory constructor with JSON
  factory Oteller.fromJson(Map<String, dynamic> json) {
    return Oteller(
      json['otel_id'] as int? ?? 0, // Eğer null gelirse 0 döndür
      json['otel_ad'] as String? ?? 'No Name', // Eğer null gelirse 'No Name' döndür
      json['otel_resim'] as String? ?? 'default_image.png', // Varsayılan bir resim ismi
      json['otel_yildiz'] as int? ?? 0, // Eğer null gelirse 0 döndür
      json['otel_aciklama'] as String? ?? 'No Description', // Varsayılan açıklama
      json['otel_fiyat'] as int? ?? 0, // Fiyatın null olma ihtimaline karşı güvenli dönüşüm
      (json['imkanlar'] as List<dynamic>?)
          ?.map((x) => Imkanlar.fromJson(x as Map<String, dynamic>))
          .toList() ?? <Imkanlar>[], // Eğer 'imkanlar' null ise boş liste döndür
      json['konum'] != null ? Konum.fromJson(json['konum'] as Map<String, dynamic>) : Konum('No City', 'No District'),
    );
  }

  int otel_id;
  String otel_ad;
  String otel_resim;
  int otel_yildiz;
  String otel_aciklama;
  int otel_fiyat;
  List<Imkanlar> imkanlar;
  Konum konum;
}
