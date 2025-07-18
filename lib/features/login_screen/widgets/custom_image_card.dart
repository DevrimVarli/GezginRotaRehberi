import 'package:flutter/material.dart';
class CustomImageCard extends StatelessWidget {
  const CustomImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    double ekranGenisligi = MediaQuery.sizeOf(context).width;
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;
    return Container(
      height:ekranYuksekligi ,
      width: ekranGenisligi,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/anaEkran.png"),fit: BoxFit.cover)
      ),
    );
  }
}
