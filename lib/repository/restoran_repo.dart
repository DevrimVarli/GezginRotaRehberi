import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';

/// Restoran verilerini assets/api.json dosyasından okuyan repository sınıfı
class RestoranRepo {
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
  }
}
