import 'package:flutter/material.dart';
import 'package:yeni_tasarim/features/introEkrani/widgets/ExploreButton_widget.dart';
import 'package:yeni_tasarim/features/introEkrani/widgets/arkaPlan_widget.dart';
import 'package:yeni_tasarim/features/introEkrani/widgets/baslikText_widget.dart';
import 'package:yeni_tasarim/features/introEkrani/widgets/metinText_widget.dart';


class IntroEkran extends StatefulWidget {
  const IntroEkran({super.key});

  @override
  State<IntroEkran> createState() => _IntroEkranState();
}

class _IntroEkranState extends State<IntroEkran> {
  @override
  Widget build(BuildContext context) {
    double ekranYuksekligi = MediaQuery.of(context).size.height;
    double ekranGenisligi = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          arkaPlanWidget(ekranYuksekligi: ekranYuksekligi, ekranGenisligi: ekranGenisligi, resimYolu: 'assets/anaEkran.png'),
          const baslikTextWidget(),
          const metinText(),
          ExploreButtonWidget(ekranYuksekligi: ekranYuksekligi, ekranGenisligi: ekranGenisligi),


        ],
         
      ),

    );
  }
}
