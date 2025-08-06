import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_tasarim/model/Konum.dart';
import 'package:yeni_tasarim/model/oteller.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/detail_screen.dart';

class OtellerListViewWidget extends ConsumerWidget {
  const OtellerListViewWidget({super.key});

  // OTELLERİ GÖSTERİYOR
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Arama sonuca göre otel listesi
    String aramaSonucu = ref.watch(
      aramaSonucuStateProvider,
    ); // Kullanıcının arama sonucu
    Konum secilenKonum = ref.watch(
      secilemKonumStateProvider,
    ); // Seçilen konum bilgisi
    bool seeAll = ref.watch(seeAllStateProvider); // "See All" durumu

    // `otelFutureProvider` AsyncValue döndüğü için burada 'when' fonksiyonunu kullanıyoruz.
    AsyncValue<List<Oteller>> otelListAsync = ref.watch(otelFutureProvider);

    return otelListAsync.when(
      data: (List<Oteller> otelList) {
        // Arama yapılmışsa, listeyi filtrele
        List<Oteller> filteredOtelList =
            aramaSonucu.isEmpty
                ? otelList.where((Oteller otel) {
                  // Eğer seeAll false ise, konuma göre filtrele
                  if (!seeAll) {
                    return otel.konum.ilceAdi.toLowerCase().contains(
                      secilenKonum.ilceAdi.toLowerCase(),
                    );
                  }
                  // Aksi takdirde tüm otelleri göster
                  return true;
                }).toList()
                : otelList
                    .where(
                      (Oteller otel) => otel.otelAd.toLowerCase().contains(
                        aramaSonucu.toLowerCase(),
                      ),
                    )
                    .toList();

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'recommended'.tr(), // Başlık
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 200, // Liste yüksekliği
                child: ListView.builder(
                  itemCount:
                      filteredOtelList.length, // Filtrelenmiş otel listesi
                  scrollDirection: Axis.horizontal, // Yatay kaydırma
                  itemBuilder: (BuildContext context, int indeks) {
                    Oteller otel = filteredOtelList[indeks]; // İlgili otel
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Otel resmine tıklandığında, detay sayfasına yönlendir
                              Navigator.push(
                                context,
                                MaterialPageRoute<Widget>(
                                  builder:
                                      (BuildContext context) =>
                                          DetayEkrani(secilenOtel: otel),
                                ),
                              );
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: 280, // Genişlik sabit
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      16,
                                    ), // Yuvarlatılmış köşeler
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        otel.otelResim,
                                      ), // Otel resmi
                                      fit: BoxFit.cover, // Resim boyutlandırma
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Otel ismi
                        Text(
                          otel.otelAd,
                          style: GoogleFonts.roboto(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      error:
          (Object error, StackTrace stackTrace) =>
              Center(child: Text(error.toString())), // Hata mesajı
      loading:
          () => const Center(
            child: CircularProgressIndicator(),
          ), // Yükleniyor göstergesi
    );
  }
}
