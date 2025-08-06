import 'package:yeni_tasarim/model/imkanlar.dart';
import 'package:yeni_tasarim/model/konum.dart';

class Restorantlar {
  // Constructor: Restorantlar sınıfının bir örneğini oluşturmak için kullanılan parametreler
  Restorantlar(
    this.restoranId,
    this.restoranAd,
    this.restoranResim,
    this.restoranPuan,
    this.restoranAciklama,
    this.restoranFiyat,
    this.imkanlar,
    this.konum,
  );

  // Factory constructor: JSON verisini alıp Restorantlar nesnesine dönüştürür
  factory Restorantlar.fromJson(Map<String, dynamic> json) {
    return Restorantlar(
      json['restoran_id'] as int? ??
          0, // 'restoran_id' varsa int olarak al, yoksa 0 döndür
      json['restoran_ad'] as String? ??
          'No Name', // 'restoran_ad' varsa String olarak al, yoksa 'No Name' döndür
      json['restoran_resim'] as String? ??
          '', // 'restoran_resim' varsa String olarak al, yoksa boş string döndür
      json['restoran_puan'] as String? ??
          'No Rating', // 'restoran_puan' varsa String olarak al, yoksa 'No Rating' döndür
      json['restoran_aciklama'] as String? ??
          'No description', // 'restoran_aciklama' varsa String olarak al, yoksa 'No description' döndür
      json['restoran_fiyat'] as int? ??
          0, // 'restoran_fiyat' varsa int olarak al, yoksa 0 döndür
      // 'imkanlar' JSON verisinden bir listeye dönüştürülüyor. Eğer 'imkanlar' null ise boş bir liste döndürülür
      (json['imkanlar'] as List<dynamic>?)
              ?.map((dynamic x) => Imkanlar.fromJson(x as Map<String, dynamic>))
              .toList() ??
          <Imkanlar>[], // Eğer 'imkanlar' null ise boş liste döndür
      // 'konum' JSON verisinden 'Konum' nesnesine dönüştürülüyor. Eğer 'konum' null ise varsayılan 'No City', 'No District' döndürülür
      json['konum'] != null
          ? Konum.fromJson(json['konum'] as Map<String, dynamic>)
          : Konum('No City', 'No District'),
    );
  }

  // Restoran bilgileri için özellikler
  int restoranId; // Restoranın benzersiz kimliği
  String restoranAd; // Restoranın adı
  String restoranResim; // Restoranın görseli (URL veya dosya adı)
  String restoranPuan; // Restoranın puanı
  String restoranAciklama; // Restoranın açıklaması
  int restoranFiyat; // Restoranın fiyatı
  List<Imkanlar> imkanlar; // Restoranın sunduğu imkanlar (liste olarak)
  Konum konum; // Restoranın konumu (Konum nesnesi)
}
