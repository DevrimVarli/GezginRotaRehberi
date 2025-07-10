import 'package:flutter/material.dart';

import '../../../model/Restorantlar.dart';
import '../../../model/oteller.dart';
class ImageWidgets extends StatelessWidget {
  Oteller? secilenOtel;
  Restorantlar? secilenRestorant;
  double ekranGenisligi;
  ImageWidgets({super.key, this.secilenOtel, this.secilenRestorant, required this.ekranGenisligi});
//OTEL VEYA RESTORANT RESMİ GÖSTERİLİYOR
  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: ekranGenisligi,
        height: 380,
        child:secilenOtel != null
            ? Image.asset(
          "assets/${secilenOtel!.otel_resim}",
          fit: BoxFit.cover,
        )
            : Image.asset(
          "assets/${secilenRestorant!.restoran_resim}",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
