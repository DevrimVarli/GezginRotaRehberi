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
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 100),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Resim alanı
                        ImageWidgets(
                          secilenOtel: widget.secilenOtel,
                          secilenRestorant: widget.secilenRestorant,
                          ekranGenisligi: ekranGenisligi,
                        ),
                        // Geri butonu
                        ArrowBackButtonWidgets(),
                        // Favori butonu
                        FavoriteButtonWidgets(),
                      ],
                    ),

                    // Mekan bilgileri
                    MekanInfoWidgets(
                      secilenRestorant: widget.secilenRestorant,
                      secilenOtel: widget.secilenOtel,
                    ),

                    // İmkanlar listesi
                    FacilitiesWidgets(
                      ekranGenisligi: ekranGenisligi,
                      secilenOtel: widget.secilenOtel,
                      secilenRestorant: widget.secilenRestorant,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: PriceWidgets(
                  ekranGenisligi: ekranGenisligi,
                  secilenOtel: widget.secilenOtel,
                  secilenRestorant: widget.secilenRestorant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
