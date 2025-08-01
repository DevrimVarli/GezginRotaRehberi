import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:yeni_tasarim/model/Konum.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/detail_screen.dart';
import 'package:yeni_tasarim/screens/location_screen.dart';
import 'package:yeni_tasarim/screens/see_all_screen.dart';

class RestorantListViewWidget extends ConsumerWidget {
  const RestorantListViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Favoriler provider'ı ile favoriler listesine erişim
    Box<String> box = ref.watch(favorilerProvider);
    // Tema renk şeması
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Arama sonucu, seçilen konum, 'See All' durumu gibi verileri provider'lardan alıyoruz
    String aramaSonucu = ref.watch(aramaSonucuStateProvider);
    AsyncValue<List<Restorantlar>> restoranListAsync = ref.watch(restoranFutureProvider);
    Konum secilenKonum = ref.watch(secilemKonumStateProvider);
    bool seeAll = ref.watch(seeAllStateProvider);

    return restoranListAsync.when(
      data: (List<Restorantlar> restoranList) {
        // Arama yapılmışsa, listeyi filtreliyoruz
        List<Restorantlar> filteredRestoranList = aramaSonucu.isEmpty
            ? restoranList.where((Restorantlar restoran) {
          // Eğer 'See All' false ise, konuma göre filtreleme yapıyoruz
          if (!seeAll) {
            return restoran.konum.ilceAdi
                .toLowerCase()
                .contains(secilenKonum.ilceAdi.toLowerCase());
          }
          // Aksi takdirde tüm restoranları gösteriyoruz
          return true;
        }).toList()
            : restoranList
            .where((Restorantlar restorant) => restorant.restoranAd
            .toLowerCase()
            .contains(aramaSonucu.toLowerCase()),)
            .toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        if (!context.mounted) return;
                        // Konum seçme sayfasına geçiş
                        await Navigator.push(
                          context,
                          MaterialPageRoute<Widget>(
                            builder: (BuildContext context) => const KonumSecPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Popular', // Başlık
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    // 'See all' butonu
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<Widget>(
                            builder: (BuildContext context) => const SeeAllEkrani(),
                          ),
                        );
                      },
                      child: Text(
                        'See all', // Başlık
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 300, // Restoran kartlarının yükseklik değeri
                child: ListView.builder(
                  itemCount: filteredRestoranList.length, // Filtrelenmiş restoranlar
                  scrollDirection: Axis.horizontal, // Yatay kaydırma
                  itemBuilder: (BuildContext context, int indeks) {
                    Restorantlar restorant = filteredRestoranList[indeks];
                    return Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            // Restoran kartına tıklanınca detay sayfasına geçiş
                            Navigator.push(
                              context,
                              MaterialPageRoute<Widget>(
                                builder: (BuildContext context) => DetayEkrani(secilenRestorant: restorant),
                              ),
                            );
                          },
                          child: Container(
                            width: 230, // Kart genişliği
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16), // Yuvarlatılmış köşeler
                              image: DecorationImage(
                                image: NetworkImage(restorant.restoranResim), // Restoran resmi
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
                              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            child: Text(
                              restorant.restoranAd, // Restoran adı
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
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
                              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Icon(
                                    Icons.star, // Yıldız ikonu
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    restorant.restoranPuan, // Restoran puanı
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: colorScheme.onSurface,
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
                              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: ValueListenableBuilder<Box<String>>(
                              valueListenable: box.listenable(),
                              builder: (BuildContext context, Box<String> favoriBox, _) {
                                bool isFavori = favoriBox.values.contains(restorant.restoranAd);

                                return IconButton(
                                  onPressed: () {
                                    // Favorilere ekleme ya da çıkarma
                                    if (isFavori) {
                                      box.delete(restorant.restoranAd);
                                    } else {
                                      box.put(restorant.restoranAd, restorant.restoranAd);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: isFavori ? colorScheme.primary : colorScheme.onSurface,
                                  ),
                                );
                              },
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
      error: (Object error, StackTrace stackTrace) => Center(child: Text(error.toString())), // Hata mesajı
      loading: () => const Center(child: CircularProgressIndicator()), // Yükleniyor göstergesi
    );
  }
}
