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
        height: 400,
        child:secilenOtel != null
            ? Image.network(
          secilenOtel!.otel_resim,
          fit: BoxFit.cover,
        )
            : Image.network(
          secilenRestorant!.restoran_resim,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
