import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_tasarim/screens/see_all_screen.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.title});

  final String
  title; // Bu parametre, kartta gösterilecek başlık adını içerir (örneğin, 'Restoranlar' veya 'Oteller')

  @override
  Widget build(BuildContext context) {
    // Tema renk düzenini almak için kullanılan değişken
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(24), // İçerik etrafında boşluk bırakıyoruz
      decoration: BoxDecoration(
        color: colorScheme.surface, // Arka plan rengi temadan alınır
        borderRadius: BorderRadius.circular(24), // Yuvarlatılmış köşeler
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colorScheme.primary.withValues(
              alpha: 0.2,
            ), // Gölge rengi temaya uygun, %20 opaklık
            blurRadius: 20, // Gölgenin bulanıklık miktarı
            offset: const Offset(0, 10), // Gölgenin kayma miktarı
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          // Favori ikonu
          Icon(
            Icons.favorite_border, // Boş kalp ikonu
            color: colorScheme.primary, // İkon rengi tema ile uyumlu
            size: 72, // İkon boyutu
          ),
          const SizedBox(height: 20), // İkon ile başlık arasında boşluk
          // Başlık metni (Favori [title] bulunamadı)
          Text(
            'no_favorites'.tr(namedArgs: <String, String>{'title': title}),
            style: GoogleFonts.montserrat(
              fontSize: 22, // Yazı boyutu
              fontWeight: FontWeight.bold, // Kalın yazı
              color: colorScheme.primary, // Yazı rengi tema ile uyumlu
            ),
            textAlign: TextAlign.center, // Metni ortala
          ),
          const SizedBox(height: 10), // Başlık ile açıklama arasında boşluk
          // Açıklama metni
          Text(
            'no_favorites_description'.tr(
              namedArgs: <String, String>{'title': title},
            ),
            style: GoogleFonts.montserrat(
              fontSize: 16, // Yazı boyutu
              color: colorScheme.onSurface.withValues(
                alpha: 0.7,
              ), // Yazı rengi yüzeydeki metin rengiyle uyumlu ve %70 opaklıkta
            ),
            textAlign: TextAlign.center, // Metni ortala
          ),
          const SizedBox(height: 20), // Açıklama ile buton arasında boşluk
          // "Keşfet" butonu
          ElevatedButton.icon(
            onPressed: () {
              // Butona tıklanıldığında "SeeAllEkrani" sayfasına geçiş yapılır
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(
                  builder: (BuildContext context) => const SeeAllEkrani(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  colorScheme
                      .primary, // Butonun arka plan rengi tema ile uyumlu
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  16,
                ), // Yuvarlatılmış köşeler
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ), // Butonun içindeki padding
            ),
            icon: Icon(
              Icons.search,
              color: colorScheme.onPrimary,
            ), // Arama ikonu
            label: Text(
              'discover'.tr(), // Butonun metni
              style: GoogleFonts.montserrat(
                fontSize: 16, // Yazı boyutu
                color: colorScheme.onPrimary, // Buton metni rengi
              ),
            ),
          ),
        ],
      ),
    );
  }
}
