import 'package:flutter/material.dart';
class arkaPlanWidget extends StatelessWidget {

//ARKA PLAN FOTOĞRAF
  const arkaPlanWidget({super.key, required this.ekranYuksekligi, required this.ekranGenisligi,required this.resimYolu});
  final double ekranYuksekligi;
  final double ekranGenisligi;
  final String resimYolu;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height:ekranYuksekligi ,
        width: ekranGenisligi,
        child: Image(image: AssetImage(resimYolu),fit: BoxFit.fill),
      );
  }
}
