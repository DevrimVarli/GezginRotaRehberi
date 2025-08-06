import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_app_bar.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_otel_button.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_restoran_button.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/favori_otel_kartlar.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/favori_restoran_kartlar.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/info_card.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';
import 'package:yeni_tasarim/model/oteller.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';

/// Kullanıcının favori otel ve restoranlarını görebileceği sayfa.
/// İki sekme (Restoran / Otel) arasında geçiş yapar.
class FavoritePageView extends ConsumerStatefulWidget {
  const FavoritePageView({super.key});

  @override
  ConsumerState<FavoritePageView> createState() => _FavoritePageViewState();
}

class _FavoritePageViewState extends ConsumerState<FavoritePageView> {
  /// Sayfa geçişlerini kontrol eden controller
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    // Sayfa açıldığında ilk sekme (Restoranlar) gösterilsin
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );

      // Favori buton state'ini sıfırla
      ref.read(favoriteButtonStateProvider.notifier).state = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Hive kutusu (favoriler)
    Box<String> box = ref.watch(favorilerProvider);

    // API / Repository'den restoran ve otel listeleri
    AsyncValue<List<Restorantlar>> restoranList = ref.watch(
      restoranFutureProvider,
    );
    AsyncValue<List<Oteller>> otelList = ref.watch(otelFutureProvider);

    double ekranGenisligi = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ekranGenisligi / 10),
        child: const CustomAppBar(),
      ),
      body: Column(
        children: <Widget>[
          // Sekme butonları (Restoranlar / Oteller)
          Flexible(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: CustomRestoranButton(pageController: _pageController),
                ),
                Expanded(
                  child: CustomOtelButton(pageController: _pageController),
                ),
              ],
            ),
          ),

          // İçerik alanı
          Flexible(
            flex: 20,
            child: PageView(
              physics:
                  const NeverScrollableScrollPhysics(), // elle kaydırmayı kapat
              controller: _pageController,
              children: <Widget>[
                // Sayfa 1: Restoran Favorileri
                restoranList.when(
                  data: (List<Restorantlar> restoranListe) {
                    return ValueListenableBuilder<Box<String>>(
                      valueListenable: box.listenable(),
                      builder: (
                        BuildContext context,
                        Box<String> favoriBox,
                        _,
                      ) {
                        // Favori restoranları filtrele
                        List<Restorantlar> filteredRestoranList =
                            favoriBox.isEmpty
                                ? <Restorantlar>[]
                                : restoranListe
                                    .where(
                                      (Restorantlar restoran) => favoriBox
                                          .values
                                          .contains(restoran.restoranAd),
                                    )
                                    .toList();

                        return filteredRestoranList.isEmpty
                            ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InfoCard(title: 'restaurant'.tr()),
                                ],
                              ),
                            )
                            : FavoriRestoranKartlar(
                              filteredRestoranList: filteredRestoranList,
                            );
                      },
                    );
                  },
                  error:
                      (Object error, StackTrace stackTrace) =>
                          Center(child: Text(error.toString())),
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                ),

                // Sayfa 2: Otel Favorileri
                otelList.when(
                  data: (List<Oteller> otelListe) {
                    return ValueListenableBuilder<Box<String>>(
                      valueListenable: box.listenable(),
                      builder: (
                        BuildContext context,
                        Box<String> favoriBox,
                        _,
                      ) {
                        // Favori otelleri filtrele
                        List<Oteller> filteredOtelList =
                            box.isEmpty
                                ? <Oteller>[]
                                : otelListe
                                    .where(
                                      (Oteller otel) => favoriBox.values
                                          .contains(otel.otelAd),
                                    )
                                    .toList();

                        return filteredOtelList.isEmpty
                            ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InfoCard(title: 'hotel'.tr()),
                                ],
                              ),
                            )
                            : FavoriOtelKartlar(
                              filteredOtelList: filteredOtelList,
                            );
                      },
                    );
                  },
                  error:
                      (Object error, StackTrace stackTrace) =>
                          Center(child: Text(error.toString())),
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
