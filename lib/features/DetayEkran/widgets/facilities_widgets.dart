import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_tasarim/model/imkanlar.dart';
import 'package:yeni_tasarim/model/restorantlar.dart';
import 'package:yeni_tasarim/model/oteller.dart';

class FacilitiesWidgets extends ConsumerWidget {
  const FacilitiesWidgets({
    super.key,
    required this.ekranGenisligi, // Ekran genişliği
    this.secilenOtel, // Seçilen otel (null olabileceği için opsiyonel)
    this.secilenRestorant, // Seçilen restoran (null olabileceği için opsiyonel)
  });

  final Oteller? secilenOtel; // Seçilen otel
  final Restorantlar? secilenRestorant; // Seçilen restoran
  final double ekranGenisligi; // Ekran genişliği

  // İmkan türüne göre ikonları döndüren fonksiyon
  Icon iconuBuL(String gelenVeri) {
    if (gelenVeri == 'wifi') {
      return const Icon(Icons.wifi);
    } else if (gelenVeri == 'hot_tub') {
      return const Icon(Icons.hot_tub);
    } else if (gelenVeri == 'pool') {
      return const Icon(Icons.pool);
    } else {
      return const Icon(Icons.lunch_dining);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tema renk düzenini almak için kullanılan değişken
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Facilities başlığı
        Text(
          'facilities'.tr(),
          style: GoogleFonts.roboto(
            fontSize: 24,
            color: colorScheme.onSurface, // Tema rengi ile uyumlu
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16), // Başlık ve liste arasına boşluk ekliyoruz
        SizedBox(
          height: 100, // Liste yüksekliği
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Yatay kaydırma
            itemCount:
                (secilenOtel != null)
                    ? secilenOtel!
                        .imkanlar
                        .length // Eğer otel seçildiyse otelin imkanları
                    : secilenRestorant!
                        .imkanlar
                        .length, // Eğer restoran seçildiyse restoranın imkanları
            itemBuilder: (BuildContext context, int indeks) {
              // İmkanları seçilen otelden veya restorandan alıyoruz
              Imkanlar imkan =
                  (secilenOtel != null)
                      ? secilenOtel!.imkanlar[indeks]
                      : secilenRestorant!.imkanlar[indeks];

              return Container(
                width:
                    ekranGenisligi /
                    4.6, // Her bir imkanın genişliği ekranın %22'si kadar
                margin: const EdgeInsets.only(
                  right: 8,
                ), // Sağda boşluk bırakıyoruz
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(
                    alpha: 0.08,
                  ), // Arka plan rengini tema rengi ile uyumlu yapıyoruz
                  borderRadius: BorderRadius.circular(
                    12,
                  ), // Yuvarlatılmış köşeler
                ),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // İçeriği ortalıyoruz
                  children: <Widget>[
                    // İmkan ikonunu gösteriyoruz
                    iconuBuL(imkan.imkanIcon),
                    const SizedBox(
                      height: 4,
                    ), // İkon ile metin arasına boşluk ekliyoruz
                    // İmkan adı
                    Text(
                      imkan.imkanAdi.tr(),
                      style: TextStyle(
                        color:
                            colorScheme.onSurface, // Yazı rengi tema ile uyumlu
                        fontSize: 14, // Yazı boyutu
                      ),
                      textAlign: TextAlign.center, // Metni ortalıyoruz
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
