import 'package:flutter/material.dart';
import 'package:yeni_tasarim/features/introEkrani/widgets/explore_button_widgets.dart';
import 'package:yeni_tasarim/features/introEkrani/widgets/arka_plan_widget.dart';
import 'package:yeni_tasarim/features/introEkrani/widgets/baslik_text_widgets.dart';
import 'package:yeni_tasarim/features/introEkrani/widgets/metin_text.dart';

/// Uygulamanın giriş (intro) ekranı.
/// - Arka plan görseli
/// - Başlık
/// - Açıklama metni
/// - Keşfet butonu
class IntroEkran extends StatelessWidget {
  const IntroEkran({super.key});

  @override
  Widget build(BuildContext context) {
    double ekranYuksekligi = MediaQuery.of(context).size.height;
    double ekranGenisligi = MediaQuery.of(context).size.width;

    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            // Arka plan görseli
            ArkaPlanWidget(
              ekranYuksekligi: ekranYuksekligi,
              ekranGenisligi: ekranGenisligi,
              resimYolu: 'assets/anaEkran.png',
            ),

            // Başlık
            const BaslikTextWidget(),

            // Açıklama metni
            const MetinText(),

            // Keşfet butonu
            const ExploreButtonWidget(),
          ],
        ),
      ),
    );
  }
}
