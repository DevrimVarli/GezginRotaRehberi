import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:yeni_tasarim/model/oteller.dart';

/// Otel verilerini assets/api.json dosyasından okuyan repository sınıfı
class OtelRepo {
  /// assets/api.json içindeki 'oteller' listesini Oteller model listesine dönüştürür
  Future<List<Oteller>> oteller() async {
    // JSON dosyasını assets klasöründen yükle
    String jsonString = await rootBundle.loadString('assets/api.json');

    // JSON stringini Map<String, dynamic> tipine dönüştür
    Map<String, dynamic> jsonData =
    json.decode(jsonString) as Map<String, dynamic>;

    // 'oteller' anahtarındaki veriyi model listesine çevir
    List<Oteller> otellerList = (jsonData['oteller'] as List<dynamic>)
        .map((dynamic json) => Oteller.fromJson(json as Map<String, dynamic>))
        .toList();

    return otellerList;
  }
}
