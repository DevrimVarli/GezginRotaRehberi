import 'package:flutter/material.dart';
import 'package:yeni_tasarim/features/introEkrani/widgets/explore_button_widgets.dart';
import 'package:yeni_tasarim/features/introEkrani/widgets/arka_plan_widget.dart';
import 'package:yeni_tasarim/features/introEkrani/widgets/baslik_text_widgets.dart';
import 'package:yeni_tasarim/features/introEkrani/widgets/metin_text.dart';


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
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ArkaPlanWidget(ekranYuksekligi: ekranYuksekligi, ekranGenisligi: ekranGenisligi, resimYolu: 'assets/anaEkran.png'),
            const BaslikTextWidget(),
            const MetinText(),
            const ExploreButtonWidget(),
      
      
          ],
           
        ),
      
      ),
    );
  }
}
