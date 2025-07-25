import 'package:flutter/material.dart';

import 'package:yeni_tasarim/model/Restorantlar.dart';
import 'package:yeni_tasarim/model/oteller.dart';
class ImageWidgets extends StatelessWidget {
  const ImageWidgets({super.key, this.secilenOtel, this.secilenRestorant, required this.ekranGenisligi});
  final Oteller? secilenOtel;
  final Restorantlar? secilenRestorant;
  final double ekranGenisligi;
//OTEL VEYA RESTORANT RESMİ GÖSTERİLİYOR
  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
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
