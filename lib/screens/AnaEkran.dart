import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/AdresPopUpWidget.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/AppBarWidget.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/AramaTextFieldWidget.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/KategoriWidget.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/RestorantListViewWidget.dart';
import 'package:yeni_tasarim/model/Konum.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';
import 'package:yeni_tasarim/model/oteller.dart';
import 'package:yeni_tasarim/repository/AdresRepo.dart';

import '../features/AnaEkran/widgets/OtellerListViewWidget.dart';
import '../repository/RestorantRepo.dart';
import '../repository/otelRepo.dart';
import 'DetayEkrani.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  List<Restorantlar>restorantlarList=[];
  List<Oteller>otelList=[];
  Konum secilenKonum=Konum(1, "Ankara", "Çankaya");
  List<Konum> konumList = [];
  List<String> basliklar = ["Location", "Hotels","Food","Adventure","Location", "Hotels","Food","Adventure"];

  int selectedIndex= 1;
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AdresRepo().konumlar(konumList);

  }

  Widget build(BuildContext context) {
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;
    double ekranGenisligi = MediaQuery.sizeOf(context).width;
    Widget categoryWidget;

    if (basliklar[selectedIndex] == "Hotels") {
      categoryWidget = OtellerListViewWidget();
    } else if (basliklar[selectedIndex] == "Food") {
      categoryWidget = RestorantListViewWidget();
    } else {
      categoryWidget = Column(
        children: [
          RestorantListViewWidget(),
          OtellerListViewWidget(),

        ],
      );
    }

    return Scaffold(
      backgroundColor:Colors.white10 ,
      appBar: PreferredSize(preferredSize: Size.fromHeight(ekranYuksekligi/10),child: AppBarWidget(konumList,secilenKonum,ekranYuksekligi)),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
            children: [
             AramaTextFieldWidget(),
             KategoriWidget(basliklar, selectedIndex,(indeks){setState(() {
               selectedIndex=indeks;
             });}) ,
              categoryWidget







            ],
          ),
        ),
      ),
    );
  }
}
