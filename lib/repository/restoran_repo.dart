import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';

/// Restoran verilerini assets/api.json dosyasından okuyan repository sınıfı
class RestoranRepo {
  final String _url =
      'https://gist.githubusercontent.com/DevrimVarli/d98d5353665d50d947ea321840b442d3/raw/c496abc69f9f3eb0bc006e8617d7ef2892971d4e/data.json';

  Future<List<Restorantlar>> restorantlar() async {
    try {
      Response<dynamic> response = await Dio().get(_url);

      if (response.statusCode == 200) {
        // Gelen veri String olabilir, decode et
        var rawData = response.data;
        Map<String, dynamic> data = rawData is String
            ? jsonDecode(rawData) as Map<String, dynamic>
            : rawData as Map<String, dynamic>;

        // "restoranlar" listesi var mı kontrol et
        if (data['restoranlar'] is List) {
          return (data['restoranlar'] as List<dynamic>)
              .map((e) => Restorantlar.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Restoran listesi bulunamadı.');
        }
      } else {
        throw Exception('Sunucu hatası: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Restoran verileri alınamadı: $e');
    }
  }
  /*
  /// assets/api.json içindeki 'restoranlar' listesini Restorantlar model listesine dönüştürür
  Future<List<Restorantlar>> restorantlar() async {
    // JSON dosyasını assets klasöründen yükle
    String jsonString = await rootBundle.loadString('assets/api.json');

    // JSON stringini Map<String, dynamic> tipine dönüştür
    Map<String, dynamic> jsonData =
    json.decode(jsonString) as Map<String, dynamic>;

    // 'restoranlar' anahtarındaki veriyi model listesine çevir
    List<Restorantlar> restorantlarList = (jsonData['restoranlar'] as List<dynamic>)
        .map((dynamic json) => Restorantlar.fromJson(json as Map<String, dynamic>))
        .toList();

    return restorantlarList;
  }*/
}
