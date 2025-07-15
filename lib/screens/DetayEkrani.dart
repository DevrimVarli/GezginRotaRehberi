import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_tasarim/features/DetayEkran/widgets/ArrowBackButtonWidgets.dart';
import 'package:yeni_tasarim/features/DetayEkran/widgets/FavoriteButtonWidgets.dart';
import 'package:yeni_tasarim/features/DetayEkran/widgets/MekanInfoWidgets.dart';
import 'package:yeni_tasarim/features/DetayEkran/widgets/PriceWidgets.dart';
import 'package:yeni_tasarim/model/Imkanlar.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';
import 'package:yeni_tasarim/repository/IconRepo.dart';
import '../features/DetayEkran/widgets/FacilitiesWidgets.dart';
import '../features/DetayEkran/widgets/ImageWidgets.dart';
import '../model/oteller.dart';

class DetayEkrani extends StatefulWidget {
  Oteller? secilenOtel;
  Restorantlar? secilenRestorant;
  DetayEkrani({super.key, this.secilenOtel, this.secilenRestorant});

  @override
  State<DetayEkrani> createState() => _DetayEkraniState();
}

class _DetayEkraniState extends State<DetayEkrani> {
  @override
  Widget build(BuildContext context) {
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;
    double ekranGenisligi = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children:[ Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Arka plan resim
                   ImageWidgets(secilenOtel: widget.secilenOtel, secilenRestorant: widget.secilenRestorant, ekranGenisligi: ekranGenisligi),

                    // Geri butonu (sol üst)
                   ArrowBackButtonWidgets(),

                    // Favori butonu (sağ alt, biraz dışarı taşıyor)
                    FavoriteButtonWidgets(),
                  ],
                ),
                MekanInfoWidgets(secilenRestorant: widget.secilenRestorant,secilenOtel: widget.secilenOtel,),
                FacilitiesWidgets(ekranGenisligi: ekranGenisligi,secilenOtel: widget.secilenOtel,secilenRestorant: widget.secilenRestorant,),

                PriceWidgets(ekranGenisligi: ekranGenisligi,secilenOtel: widget.secilenOtel,secilenRestorant: widget.secilenRestorant,),


              ],
            ),
          ),
        ),

    ]
      ),
    );
  }
}
