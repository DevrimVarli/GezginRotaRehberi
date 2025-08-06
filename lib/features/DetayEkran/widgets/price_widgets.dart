import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_tasarim/model/restorantlar.dart';
import 'package:yeni_tasarim/model/oteller.dart';

class PriceWidgets extends StatelessWidget {
  const PriceWidgets({
    super.key,
    this.secilenOtel, // Seçilen otel
    this.secilenRestorant, // Seçilen restoran
    required this.ekranGenisligi, // Ekran genişliği
  });

  final Oteller? secilenOtel; // Seçilen otel (null olabileceği için opsiyonel)
  final Restorantlar?
  secilenRestorant; // Seçilen restoran (null olabileceği için opsiyonel)
  final double ekranGenisligi; // Ekran genişliği

  @override
  Widget build(BuildContext context) {
    // Tema renk düzenini almak için kullanılan değişken
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      width:
          ekranGenisligi, // Ekran genişliğine uyacak şekilde boyutlandırıyoruz
      height: 80, // Sabit yükseklik
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ), // Yatayda boşluk ekliyoruz
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ), // İçerideki boşluklar
      decoration: BoxDecoration(
        color: colorScheme.surface, // Arka plan rengini temadan alıyoruz
        borderRadius: BorderRadius.circular(16), // Yuvarlak köşeler
        boxShadow: <BoxShadow>[
          // Gölge efekti ekliyoruz
          BoxShadow(
            color: colorScheme.shadow.withValues(
              alpha: 0.05,
            ), // Gölge rengini tema ile uyumlu yapıyoruz
            blurRadius: 8, // Gölgenin bulanıklık miktarı
            offset: const Offset(0, 2), // Gölgenin kayma miktarı
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween, // Elemanlar arasında boşluk bırakıyoruz
        children: <Widget>[
          // Fiyat bilgisi kısmı
          Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Yükseklik ortalamayı sağlıyoruz
            crossAxisAlignment: CrossAxisAlignment.start, // Soldan hizalama
            children: <Widget>[
              // Fiyat metni
              Text(
                'price'.tr(),
                style: GoogleFonts.roboto(
                  fontSize: 18, // Yazı boyutu
                  color: colorScheme.onSurface, // Yazı rengi tema ile uyumlu
                  fontWeight: FontWeight.bold, // Kalın yazı
                ),
              ),
              // Seçilen otel veya restoranın fiyatı
              Text(
                secilenOtel != null
                    ? '€${secilenOtel!.otelFiyat}' // Otel fiyatı
                    : '€${secilenRestorant!.restoranFiyat}', // Restoran fiyatı
                style: GoogleFonts.roboto(
                  fontSize: 32, // Yazı boyutu
                  color: colorScheme.tertiary, // Öne çıkan fiyat rengi
                  fontWeight: FontWeight.bold, // Kalın yazı
                ),
              ),
            ],
          ),

          // Hemen rezerve et butonu
          SizedBox(
            width: ekranGenisligi / 2, // Buton genişliği ekranın yarısı kadar
            height: 60, // Buton yüksekliği
            child: ElevatedButton(
              onPressed: () {
                // Butona tıklanabilirlik eklenebilir
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary, // Butonun arka plan rengi
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ), // Buton içi padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ), // Yuvarlatılmış köşeler
                ),
              ),
              child: Text(
                'book_now'.tr(), // Buton metni
                style: GoogleFonts.roboto(
                  fontSize: 20, // Yazı boyutu
                  color: colorScheme.onPrimary, // Yazı rengi tema ile uyumlu
                  fontWeight: FontWeight.bold, // Kalın yazı
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
