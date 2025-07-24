import 'package:flutter/material.dart';
import 'package:yeni_tasarim/features/DetayEkran/widgets/ArrowBackButtonWidgets.dart';
import 'package:yeni_tasarim/features/DetayEkran/widgets/FavoriteButtonWidgets.dart';
import 'package:yeni_tasarim/features/DetayEkran/widgets/MekanInfoWidgets.dart';
import 'package:yeni_tasarim/features/DetayEkran/widgets/PriceWidgets.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';
import 'package:yeni_tasarim/model/oteller.dart';
import 'package:yeni_tasarim/features/DetayEkran/widgets/FacilitiesWidgets.dart';
import 'package:yeni_tasarim/features/DetayEkran/widgets/ImageWidgets.dart';

class DetayEkrani extends StatefulWidget {

  const DetayEkrani({super.key, this.secilenOtel, this.secilenRestorant});
  final Oteller? secilenOtel;
  final Restorantlar? secilenRestorant;

  @override
  State<DetayEkrani> createState() => _DetayEkraniState();
}

class _DetayEkraniState extends State<DetayEkrani> {
  @override
  Widget build(BuildContext context) {
    double ekranGenisligi = MediaQuery.sizeOf(context).width;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16,  bottom: 100,),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        // Resim alanı
                        ImageWidgets(
                          secilenOtel: widget.secilenOtel,
                          secilenRestorant: widget.secilenRestorant,
                          ekranGenisligi: ekranGenisligi,
                        ),

                        // Geri butonu
                        const ArrowBackButtonWidgets(),

                        // Favori butonu
                        FavoriteButtonWidgets(
                          mekanAdi: widget.secilenOtel != null
                              ? widget.secilenOtel!.otel_ad
                              : widget.secilenRestorant!.restoran_ad,
                        ),
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

            // Fiyat kutusu
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: colorScheme.shadow.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
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
