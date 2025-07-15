import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:yeni_tasarim/model/oteller.dart';

class otelRepo{
  Future <List<Oteller>>oteller()async{
      String jsonString=await rootBundle.loadString("assets/api.json");
      Map<String,dynamic> jsonData=json.decode(jsonString);
      var otellerList = (jsonData['oteller'] as List)
          .map((json) => Oteller.fromJson(json))
          .toList();
      return otellerList;

  }
}