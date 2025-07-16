import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_tasarim/repository/otelRepo.dart';

import '../../../model/oteller.dart';
import '../../../providers/all_providers.dart';
import '../../../screens/DetayEkrani.dart';

class OtellerListViewWidget extends ConsumerWidget {
  // OTELLERİ GÖSTERİYOR
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Arama sonuca göre otel listesi
    final aramaSonucu = ref.watch(aramaSonucuStateProvider);
    final secilenKonum = ref.watch(secilemKonumStateProvider);
    final seeAll = ref.watch(seeAllStateProvider);

    // `otelFutureProvider` AsyncValue döndüğü için burada 'when' fonksiyonunu kullanıyoruz.
    final otelListAsync = ref.watch(otelFutureProvider);

    return otelListAsync.when(
      data: (otelList) {
        // Arama yapılmışsa, listeyi filtrele
        final filteredOtelList = aramaSonucu.isEmpty
            ? otelList.where((otel) {
          // Eğer seeAll false ise konuma göre filtrele
          if (!seeAll && otel.konum != null && secilenKonum != null) {
            return otel.konum.ilce_adi.toLowerCase().contains(
              secilenKonum.ilce_adi.toLowerCase(),
            );
          }
          // Aksi takdirde tüm otelleri göster
          return true;
        }).toList()
            : otelList
            .where((otel) => otel.otel_ad
            .toLowerCase()
            .contains(aramaSonucu.toLowerCase()))
            .toList();


        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recommended",
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: filteredOtelList.length, // Filtrelenmiş listeyi kullanıyoruz
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, indeks) {
                    Oteller otel = filteredOtelList[indeks];
                    return Column(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetayEkrani(secilenOtel: otel),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: 280, // Genişliği sabitle
                                  margin: EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: NetworkImage(otel.otel_resim),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          otel.otel_ad,
                          style: GoogleFonts.roboto(
                            fontSize: 22,
                            color: Colors.black,
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
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
