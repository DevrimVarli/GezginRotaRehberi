import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_tasarim/model/Konum.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/detail_screen.dart';
import 'package:yeni_tasarim/screens/see_all_screen.dart';

class RestorantListViewWidget extends ConsumerWidget {
  const RestorantListViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    String aramaSonucu = ref.watch(aramaSonucuStateProvider);
    AsyncValue<List<Restorantlar>> restoranListAsync = ref.watch(restoranFutureProvider);
    Konum secilenKonum = ref.watch(secilemKonumStateProvider);
    bool seeAll = ref.watch(seeAllStateProvider);

    return restoranListAsync.when(
      data: (List<Restorantlar> restoranList) {
        List<Restorantlar> filteredRestoranList = aramaSonucu.isEmpty
            ? restoranList.where((Restorantlar restoran) {
          if (!seeAll) {
            return restoran.konum.ilceAdi
                .toLowerCase()
                .contains(secilenKonum.ilceAdi.toLowerCase());
          }
          return true;
        }).toList()
            : restoranList
            .where((Restorantlar restorant) => restorant.restoran_ad
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
                    Text(
                      'Popular',
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<Widget>(builder: (BuildContext context) => const SeeAllEkrani()),
                        );
                      },
                      child: Text(
                        'See all',
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
                height: 300,
                child: ListView.builder(
                  itemCount: filteredRestoranList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int indeks) {
                    Restorantlar restorant = filteredRestoranList[indeks];
                    bool isFavorite = ref.watch(favoriListesiProvider).contains(restorant.restoran_ad);

                    return Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<Widget>(
                                builder: (BuildContext context) => DetayEkrani(secilenRestorant: restorant),
                              ),
                            );
                          },
                          child: Container(
                            width: 230,
                            margin: const EdgeInsets.only(right: 12),
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
                              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            child: Text(
                              restorant.restoran_ad,
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
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    restorant.restoran_puan,
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
                            child: IconButton(
                              onPressed: () {
                                StateController<List<String>> favoriNotifier = ref.read(favoriListesiProvider.notifier);
                                List<String> currentList = <String>[...favoriNotifier.state];

                                if (currentList.contains(restorant.restoran_ad)) {
                                  currentList.remove(restorant.restoran_ad);
                                } else {
                                  currentList.add(restorant.restoran_ad);
                                }

                                favoriNotifier.state = currentList;
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: isFavorite
                                    ? colorScheme.primary
                                    : colorScheme.onSurface,
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
      error: (Object error, StackTrace stackTrace) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
