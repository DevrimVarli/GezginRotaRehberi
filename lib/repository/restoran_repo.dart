import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';


class ResetoranRepo {
  Future<List<Restorantlar>> restorantlar() async {
    // JSON dosyasını yükleyin
    String jsonString = await rootBundle.loadString('assets/api.json');

    // JSON'u decode edin ve Map<String, dynamic> türüne güvenli bir şekilde cast edin
    Map<String, dynamic> jsonData = json.decode(jsonString) as Map<String, dynamic>;

    // 'imkanlar' anahtarındaki veriyi listeye dönüştürün
    List<Restorantlar> restorantlarList = (jsonData['restoranlar'] as List)
        .map((json) => Restorantlar.fromJson(json as Map<String, dynamic>))
        .toList();

    return restorantlarList;
  }
}
