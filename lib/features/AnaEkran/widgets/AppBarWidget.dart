import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:yeni_tasarim/features/AnaEkran/widgets/AdresPopUpWidget.dart';
class AppBarWidget extends StatefulWidget {
  AppBarWidget(this.ekranYuksekligi, {super.key});
  double ekranYuksekligi;
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
        children: <Widget>[
          Text('Explore',style:GoogleFonts.montserrat(fontSize: 24,fontWeight: FontWeight.w500) ,),
          Text('Aspen',style:GoogleFonts.montserrat(fontSize: 48,fontWeight: FontWeight.w500) ,),
        ],
      ),
      actions: const <Widget>[
        AdresPopUpWidget(),
      ],
    );
  }
}
