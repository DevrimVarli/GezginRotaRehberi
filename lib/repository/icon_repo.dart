import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:yeni_tasarim/model/Imkanlar.dart';

/// İmkan verilerini assets/api.json dosyasından okuyan repository sınıfı
class ImkanRepo {
  /// assets/api.json içindeki 'imkanlar' listesini Imkanlar model listesine dönüştürür
  Future<List<Imkanlar>> imkanlar() async {
    // JSON dosyasını assets klasöründen yükle
    String jsonString = await rootBundle.loadString('assets/api.json');

    // JSON stringini decode edip Map<String, dynamic> tipine dönüştür
    Map<String, dynamic> jsonData = json.decode(jsonString) as Map<String, dynamic>;

    // HATA DÜZELTME:
    // Burada jsonData['imkanlar'] aslında List<dynamic> tipinde olur.
    // Senin kodunda List<Imkanlar> yazıldığı için runtime hatası çıkabilir.
    List<Imkanlar> imkanlarList = (jsonData['imkanlar'] as List<dynamic>)
        .map((dynamic json) => Imkanlar.fromJson(json as Map<String, dynamic>))
        .toList();

    return imkanlarList;
  }
}
