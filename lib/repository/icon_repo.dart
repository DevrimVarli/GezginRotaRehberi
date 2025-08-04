import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:yeni_tasarim/model/Imkanlar.dart';

/// İmkan verilerini assets/api.json dosyasından okuyan repository sınıfı
class ImkanRepo {
 /* /// assets/api.json içindeki 'imkanlar' listesini Imkanlar model listesine dönüştürür
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
  }*/
  final String _url =
      'https://gist.githubusercontent.com/DevrimVarli/d98d5353665d50d947ea321840b442d3/raw/c496abc69f9f3eb0bc006e8617d7ef2892971d4e/data.json';

  Future<List<Imkanlar>> imkanlar() async {
    try {
      Response<dynamic> response = await Dio().get(_url);

      if (response.statusCode == 200) {
        // Gelen veri String olabilir, decode et
        var rawData = response.data;
        Map<String, dynamic> data = rawData is String
            ? jsonDecode(rawData) as Map<String, dynamic>
            : rawData as Map<String, dynamic>;

        // "imkanlar" listesi var mı kontrol et
        if (data['imkanlar'] is List) {
          return (data['imkanlar'] as List<dynamic>)
              .map((e) => Imkanlar.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('İmkan listesi bulunamadı.');
        }
      } else {
        throw Exception('Sunucu hatası: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('İmkan verileri alınamadı: $e');
    }
  }
}
