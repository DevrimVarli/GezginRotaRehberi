import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';
import 'package:yeni_tasarim/model/oteller.dart';

class ResetoranRepo{
  Future <List<Restorantlar>>restorantlar()async{
    String jsonString=await rootBundle.loadString("assets/api.json");
    Map<String,dynamic> jsonData=json.decode(jsonString);
    var restoranlarList = (jsonData['restoranlar'] as List)
        .map((json) => Restorantlar.fromJson(json))
        .toList();
    return restoranlarList;

  }
}