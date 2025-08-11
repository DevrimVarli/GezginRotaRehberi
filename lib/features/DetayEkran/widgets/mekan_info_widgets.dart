import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_tasarim/model/restorantlar.dart';
import 'package:yeni_tasarim/model/oteller.dart';

class MekanInfoWidgets extends StatelessWidget {
  const MekanInfoWidgets({super.key, this.secilenOtel, this.secilenRestorant});

  final Oteller? secilenOtel; // Seçilen otel
  final Restorantlar? secilenRestorant; // Seçilen restoran

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(
        top: 32,
        bottom: 24,
      ), // Üst ve alt boşluklar
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Başlık ve içeriklerin sola hizalanması
        children: <Widget>[
          // Başlık ve harita linki
          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween, // Başlık ve harita linki arasına boşluk
            children: <Widget>[
              // Otel veya restoran adı
              Text(
                secilenOtel != null
                    ? secilenOtel!
                        .otelAd // Otel adı
                    : secilenRestorant!.restoranAd, // Restoran adı
                style: GoogleFonts.montserrat(
                  fontSize:
                      (secilenOtel != null
                                  ? secilenOtel!.otelAd.length
                                  : secilenRestorant!.restoranAd.length) >
                              24
                          ? 14 // Uzun adlar için font boyutu küçültülür
                          : 20, // Kısa adlar için font boyutu 24
                  color: colorScheme.onSurface, // Yazı rengi tema ile uyumlu
                  fontWeight: FontWeight.bold, // Yazı kalınlığı
                ),
              ),
              // Harita linki
              Text(
                'show_map'.tr(),
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: colorScheme.primary, // Tema ile uyumlu renk
                  fontWeight: FontWeight.bold, // Yazı kalınlığı
                ),
              ),
            ],
          ),

          const SizedBox(height: 8), // Başlık ve puan kısmı arasına boşluk
          // Puan ve yorum sayısı
          Row(
            children: <Widget>[
              const Icon(Icons.star, color: Colors.amber), // Yıldız ikonu
              const SizedBox(width: 4), // İkon ile yazı arasına boşluk
              // Puan değeri
              Text(
                secilenOtel != null
                    ? secilenOtel!.otelYildiz
                        .toString() // Otel puanı
                    : secilenRestorant!.restoranPuan, // Restoran puanı
                style: GoogleFonts.roboto(
                  fontSize: 18, // Yazı boyutu
                  color: colorScheme.outlineVariant, // Tema rengi
                ),
              ),
              const SizedBox(width: 4), // Puan ile yorum sayısı arasına boşluk
              // Yorum sayısı
              Text(
                'reviews'.tr(), // Sabit yorum sayısı
                style: GoogleFonts.roboto(
                  fontSize: 18, // Yazı boyutu
                  color: colorScheme.outlineVariant, // Tema rengi
                ),
              ),
            ],
          ),

          const SizedBox(height: 12), // Puan ve açıklama arasına boşluk
          // Açıklama kısmı
          Text(
            secilenOtel != null
                ? secilenOtel!
                    .otelAciklama // Otel açıklaması
                : secilenRestorant!.restoranAciklama, // Restoran açıklaması
            style: GoogleFonts.roboto(
              fontSize: 18, // Yazı boyutu
              color: colorScheme.onSurface, // Yazı rengi
            ),
          ),

          const SizedBox(height: 4), // Açıklama ve "Read more" arasına boşluk
          // "Read more" linki
          TextButton(
            onPressed: () {
              // Burada herhangi bir işlem yapılabilir (örneğin açıklamanın tamamını gösterme)
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero, // Padding'i sıfırlıyoruz
            ),
            child: Row(
              children: <Widget>[
                Text(
                  'read_more'.tr(), // Daha fazla oku metni
                  style: GoogleFonts.roboto(
                    fontSize: 18, // Yazı boyutu
                    color: colorScheme.primary, // Tema rengi
                    fontWeight: FontWeight.bold, // Yazı kalınlığı
                  ),
                ),
                // Ok simgesi
                Icon(
                  Icons.keyboard_arrow_down,
                  color: colorScheme.primary, // Tema rengi
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
