import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yeni_tasarim/model/Imkanlar.dart';

import '../model/Imkanlar.dart';

class IconRepo{
  void imkanlar(List<Imkanlar>imkanList){
    Imkanlar imkan1 = Imkanlar(1, "Heater", Icon(Icons.wifi,color: Colors.grey,size: 48,));
    Imkanlar imkan2 = Imkanlar(1, "Dinner", Icon(Icons.lunch_dining,color: Colors.grey,size: 48,));
    Imkanlar imkan3 = Imkanlar(1, "Tub", Icon(Icons.hot_tub,color: Colors.grey,size: 48,));
    Imkanlar imkan4 = Imkanlar(1, "Pool", Icon(Icons.pool,color: Colors.grey,size: 48,));
    imkanList.add(imkan1);
    imkanList.add(imkan2);
    imkanList.add(imkan3);
    imkanList.add(imkan4);
  }
}