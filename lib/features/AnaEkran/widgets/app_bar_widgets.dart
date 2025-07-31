import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/adres_pop_up_widgets.dart';
class AppBarWidget extends StatefulWidget {
 const AppBarWidget({super.key});

//APPBAR İÇERİĞİ GÖSTERİLİYOR
  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    double ekranYuksekligi = MediaQuery.of(context).size.height;
    return AppBar(
      toolbarHeight: ekranYuksekligi/10,
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
