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
    String aramaSonucu = ref.watch(aramaSonucuStateProvider);
    Konum secilenKonum = ref.watch(secilemKonumStateProvider);
    bool seeAll = ref.watch(seeAllStateProvider);

    // `otelFutureProvider` AsyncValue döndüğü için burada 'when' fonksiyonunu kullanıyoruz.
    AsyncValue<List<Oteller>> otelListAsync = ref.watch(otelFutureProvider);

    return otelListAsync.when(
      data: (List<Oteller> otelList) {
        // Arama yapılmışsa, listeyi filtrele
        List<Oteller> filteredOtelList = aramaSonucu.isEmpty
            ? otelList.where((Oteller otel) {
          // Eğer seeAll false ise konuma göre filtrele
          if (!seeAll) {
            return otel.konum.ilceAdi.toLowerCase().contains(
              secilenKonum.ilceAdi.toLowerCase(),
            );
          }
          // Aksi takdirde tüm otelleri göster
          return true;
        }).toList()
            : otelList
            .where((Oteller otel) => otel.otelAd
            .toLowerCase()
            .contains(aramaSonucu.toLowerCase()),)
            .toList();


        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recommended',
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                   // color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: filteredOtelList.length, // Filtrelenmiş listeyi kullanıyoruz
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int indeks) {
                    Oteller otel = filteredOtelList[indeks];
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<Widget>(
                                  builder: (BuildContext context) =>
                                      DetayEkrani(secilenOtel: otel),
                                ),
                              );
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: 280, // Genişliği sabitle
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: NetworkImage(otel.otelResim),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          otel.otelAd,
                          style: GoogleFonts.roboto(
                            fontSize: 22,
                            //color: Colors.black,
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
      error: (Object error, StackTrace stackTrace) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
