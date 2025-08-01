import 'package:yeni_tasarim/model/Imkanlar.dart';
import 'package:yeni_tasarim/model/Konum.dart';

class Oteller {
  // Constructor: Oteller sınıfının bir örneğini oluşturmak için kullanılan parametreler
  Oteller(
      this.otelId,
      this.otelAd,
      this.otelResim,
      this.otelYildiz,
      this.otelAciklama,
      this.otelFiyat,
      this.imkanlar,
      this.konum,
      );

  // factory constructor with JSON: JSON verisini alıp Oteller nesnesine dönüştürür
  factory Oteller.fromJson(Map<String, dynamic> json) {
    return Oteller(
      json['otel_id'] as int? ?? 0, // 'otel_id' varsa int olarak al, yoksa 0 döndür
      json['otel_ad'] as String? ?? 'No Name', // 'otel_ad' varsa String olarak al, yoksa 'No Name' döndür
      json['otel_resim'] as String? ?? 'default_image.png', // 'otel_resim' varsa String olarak al, yoksa varsayılan resim döndür
      json['otel_yildiz'] as int? ?? 0, // 'otel_yildiz' varsa int olarak al, yoksa 0 döndür
      json['otel_aciklama'] as String? ?? 'No Description', // 'otel_aciklama' varsa String olarak al, yoksa 'No Description' döndür
      json['otel_fiyat'] as int? ?? 0, // 'otel_fiyat' varsa int olarak al, yoksa 0 döndür
      (json['imkanlar'] as List<dynamic>?) // 'imkanlar' varsa bir liste olarak al
          ?.map((x) => Imkanlar.fromJson(x as Map<String, dynamic>)) // Her bir öğeyi 'Imkanlar' nesnesine dönüştür
          .toList() ?? <Imkanlar>[], // Eğer 'imkanlar' null ise boş liste döndür
      json['konum'] != null // Eğer 'konum' varsa, onu 'Konum' nesnesine dönüştür
          ? Konum.fromJson(json['konum'] as Map<String, dynamic>)
          : Konum('No City', 'No District'), // Eğer 'konum' null ise varsayılan 'No City', 'No District' döndür
    );
  }

  // Otel bilgileri için özellikler
  int otelId;         // Otelin benzersiz kimliği
  String otelAd;      // Otelin adı
  String otelResim;   // Otelin resmi (URL veya dosya adı)
  int otelYildiz;     // Otelin yıldız sayısı (puan)
  String otelAciklama; // Otelin açıklaması
  int otelFiyat;      // Otelin fiyatı
  List<Imkanlar> imkanlar; // Otelin imkanları (liste olarak)
  Konum konum;        // Otelin konumu (Konum nesnesi)
}
