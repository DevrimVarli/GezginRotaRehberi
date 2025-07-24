import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:yeni_tasarim/model/oteller.dart';

class otelRepo {
  Future<List<Oteller>> oteller() async {
    // JSON dosyasını yükleyin
    String jsonString = await rootBundle.loadString('assets/api.json');

    // JSON'u decode edin ve Map<String, dynamic> türüne güvenli bir şekilde cast edin
    Map<String, dynamic> jsonData = json.decode(jsonString) as Map<String, dynamic>;

    // 'imkanlar' anahtarındaki veriyi listeye dönüştürün
    List<Oteller> otellerList = (jsonData['oteller'] as List)
        .map((json) => Oteller.fromJson(json as Map<String, dynamic>))
        .toList();

    return otellerList;
  }
}
