import 'package:flutter/material.dart';
import 'package:yeni_tasarim/features/DetayEkran/widgets/arrow_back_button_widgets.dart';
import 'package:yeni_tasarim/features/DetayEkran/widgets/facilities_widgets.dart';
import 'package:yeni_tasarim/features/DetayEkran/widgets/favorite_button_widgets.dart';
import 'package:yeni_tasarim/features/DetayEkran/widgets/image_widgets.dart';
import 'package:yeni_tasarim/features/DetayEkran/widgets/mekan_info_widgets.dart';
import 'package:yeni_tasarim/features/DetayEkran/widgets/price_widgets.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';
import 'package:yeni_tasarim/model/oteller.dart';

/// Mekan detay ekranı.
/// Hem Oteller hem de Restoranlar için ortak kullanılabilir.
/// Görsel, mekan bilgileri, imkanlar, fiyat ve favori ekleme butonlarını içerir.
class DetayEkrani extends StatefulWidget {
  const DetayEkrani({super.key, this.secilenOtel, this.secilenRestorant});

  /// Kullanıcı otel seçmişse dolu olur
  final Oteller? secilenOtel;

  /// Kullanıcı restoran seçmişse dolu olur
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
            // İçerik
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 100),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        // Mekan görseli
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
                              ? widget.secilenOtel!.otelAd
                              : widget.secilenRestorant!.restoranAd,
                        ),
                      ],
                    ),

                    // Mekan detay bilgileri
                    MekanInfoWidgets(
                      secilenRestorant: widget.secilenRestorant,
                      secilenOtel: widget.secilenOtel,
                    ),

                    // İmkanlar
                    FacilitiesWidgets(
                      ekranGenisligi: ekranGenisligi,
                      secilenOtel: widget.secilenOtel,
                      secilenRestorant: widget.secilenRestorant,
                    ),
                  ],
                ),
              ),
            ),

            // Sayfanın alt kısmındaki fiyat kutusu
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
