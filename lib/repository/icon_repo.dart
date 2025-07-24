import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:yeni_tasarim/model/Imkanlar.dart';

class ImkanRepo {
  Future<List<Imkanlar>> imkanlar() async {
    // JSON dosyasını yükleyin
    String jsonString = await rootBundle.loadString('assets/api.json');

    // JSON'u decode edin ve Map<String, dynamic> türüne güvenli bir şekilde cast edin
    Map<String, dynamic> jsonData = json.decode(jsonString) as Map<String, dynamic>;

    // 'imkanlar' anahtarındaki veriyi listeye dönüştürün
    List<Imkanlar> imkanlarList = (jsonData['imkanlar'] as List<Imkanlar>)
        .map((json) => Imkanlar.fromJson(json as Map<String, dynamic>))
        .toList();

    return imkanlarList;
  }
}
