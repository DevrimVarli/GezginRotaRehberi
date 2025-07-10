import 'package:flutter/material.dart';
class arkaPlanWidget extends StatelessWidget {
  final double ekranYuksekligi;
  final double ekranGenisligi;
  final String resimYolu;


  arkaPlanWidget({required this.ekranYuksekligi, required this.ekranGenisligi,required this.resimYolu});

  @override
  Widget build(BuildContext context) {
    return Container(
        height:ekranYuksekligi ,
        width: ekranGenisligi,
        child: Image(image: AssetImage(resimYolu),fit: BoxFit.fill),
      );
  }
}
