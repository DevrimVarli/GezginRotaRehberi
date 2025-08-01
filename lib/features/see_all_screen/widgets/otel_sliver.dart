import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:yeni_tasarim/model/oteller.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/detail_screen.dart';

class OtelSliver extends ConsumerWidget {
  const OtelSliver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Hive'dan favori otellerin listesini alıyoruz
    Box<String> box = Hive.box<String>('favoriler');

    // Oteller listesini alıyoruz
    AsyncValue<List<Oteller>> otelList = ref.watch(otelFutureProvider);

    // Tema renk şeması
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Ekranın yüksekliği ve genişliği
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;
    double ekranGenisligi = MediaQuery.sizeOf(context).width;

    // Otellerin listesi yüklendiğinde (data), bir SliverList döndürülür
    return otelList.when(
      data: (List<Oteller> otelListe) => SliverList(
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            Oteller otel = otelListe[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  // Otel kartına tıklanırsa, detay ekranına yönlendirilir
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(builder: (BuildContext context) => DetayEkrani(secilenOtel: otel)),
                  );
                },
                child: Stack(
                  children: <Widget>[
                    // Otelin resmini gösteren arka plan
                    Container(
                      height: ekranYuksekligi / 4,
                      width: ekranGenisligi,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(otel.otelResim),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Resmin üzerine eklenen renkli gradient
                    Container(
                      height: ekranYuksekligi / 4,
                      width: ekranGenisligi,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: <Color>[
                            Colors.black.withValues(alpha: 0.17),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    // Otelin adı
                    Positioned(
                      left: 5,
                      top: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surface.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(
                          otel.otelAd,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Otel puanını gösteren alan
                    Positioned(
                      right: 5,
                      top: 10,
                      child: Container(
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                          color: colorScheme.surface.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            Text(
                              otel.otelYildiz.toString(),
                              style: GoogleFonts.roboto(
                                fontSize: 22,
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Favori ekleme/çıkarma butonu
                    Positioned(
                      bottom: 5,
                      right: 10,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: colorScheme.surface.withValues(alpha: 0.85),
                        ),
                        child: ValueListenableBuilder<Box<String>>(
                          valueListenable: box.listenable(),
                          builder: (BuildContext context, Box<String> favoriBox, _) {
                            bool isFavori = favoriBox.values.contains(otel.otelAd);

                            return IconButton(
                              onPressed: () {
                                // Favorilere ekle/çıkar
                                if (isFavori) {
                                  box.delete(otel.otelAd); // Favorilerden çıkar
                                } else {
                                  box.put(otel.otelAd, otel.otelAd); // Favorilere ekle
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
                ),
              ),
            );
          },
          childCount: otelListe.length, // Otellerin toplam sayısı
        ),
      ),
      error: (Object error, StackTrace stackTrace) => SliverFillRemaining(
        child: Center(child: Text(error.toString())), // Hata durumu
      ),
      loading: () => const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()), // Yükleniyor durumu
      ),
    );
  }
}
