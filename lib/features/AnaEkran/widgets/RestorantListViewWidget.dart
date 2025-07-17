import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yeni_tasarim/model/Konum.dart';
import 'package:yeni_tasarim/screens/SeeAllEkrani.dart';

import '../../../model/Restorantlar.dart';
import '../../../providers/all_providers.dart';
import '../../../screens/DetayEkrani.dart';

class RestorantListViewWidget extends ConsumerWidget {
  // RESTORANLARI GÖSTERİYOR
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final aramaSonucu = ref.watch(aramaSonucuStateProvider);
    final restoranListAsync = ref.watch(restoranFutureProvider);
    final secilenKonum = ref.watch(secilemKonumStateProvider);
    final seeAll = ref.watch(seeAllStateProvider);

    return restoranListAsync.when(
      data: (restoranList) {
        final filteredRestoranList = aramaSonucu.isEmpty
            ? restoranList.where((restoran) {
          // Eğer seeAll false ise konuma göre filtrele
          if (!seeAll && restoran.konum != null && secilenKonum != null) {
            return restoran.konum.ilce_adi.toLowerCase().contains(
              secilenKonum.ilce_adi.toLowerCase(),
            );
          }
          // Aksi takdirde tüm otelleri göster
          return true;
        }).toList()
            : restoranList.where((restorant) =>
            restorant.restoran_ad.toLowerCase().contains(aramaSonucu.toLowerCase()))
            .toList();

        return Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular",
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SeeAllEkrani()));
                      },
                      child: Text(
                        "See all",
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: filteredRestoranList.length, // Filtrelenmiş listeyi kullanıyoruz
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, indeks) {
                    Restorantlar restorant = filteredRestoranList[indeks];
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetayEkrani(secilenRestorant: restorant),
                              ),
                            );
                          },
                          child: Container(
                            width: 230, // Genişliği sabitle
                            margin: EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: NetworkImage(restorant.restoran_resim),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 5,
                          bottom: 60,
                          child: Container(
                            decoration: BoxDecoration(
                              color: HexColor("#4D5652"),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      restorant.restoran_ad,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 5,
                          bottom: 10,
                          child: Container(
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                              color: HexColor("#4D5652"),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    restorant.restoran_puan,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 30,
                          bottom: 10,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: HexColor("#4D5652"),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: IconButton(
                              onPressed: () {
                                final favoriNotifier = ref.read(favoriListesiProvider.notifier);
                                final currentList = [...favoriNotifier.state];

                                if (currentList.contains(restorant.restoran_ad)) {
                                  currentList.remove(restorant.restoran_ad);
                                } else {
                                  currentList.add(restorant.restoran_ad);
                                }

                                favoriNotifier.state = currentList;
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: ref.watch(favoriListesiProvider).contains(restorant.restoran_ad)
                                    ? Colors.blue
                                    : Colors.white,
                              ),
                            ),
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
