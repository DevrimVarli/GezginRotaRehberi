import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/Konum.dart';
import 'AdresPopUpWidget.dart';
class AppBarWidget extends StatefulWidget {
  double ekranYuksekligi;
  AppBarWidget(this.ekranYuksekligi);
//APPBAR İÇERİĞİ GÖSTERİLİYOR
  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: widget.ekranYuksekligi/10,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Explore",style:GoogleFonts.montserrat(fontSize: 24,fontWeight: FontWeight.w500) ,),
          Text("Aspen",style:GoogleFonts.montserrat(fontSize: 48,fontWeight: FontWeight.w500) ,),
        ],
      ),
      actions: [
        AdresPopUpWidget(),
      ],
    );
  }
}
