import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:yeni_tasarim/model/Imkanlar.dart';
import 'package:yeni_tasarim/model/oteller.dart';

class imkanRepo{
  Future <List<Imkanlar>>imkanlar()async{
    String jsonString=await rootBundle.loadString("assets/api.json");
    Map<String,dynamic> jsonData=json.decode(jsonString);
    var imkanlarList = (jsonData['imkanlar'] as List)
        .map((json) => Imkanlar.fromJson(json))
        .toList();
    return imkanlarList;

  }
}