import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_app_bar.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/info_card.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';
import 'package:yeni_tasarim/model/oteller.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_otel_button.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_restoran_button.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/favori_otel_kartlar.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/favori_restoran_kartlar.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';

class FavoritePageView extends ConsumerWidget {
  const FavoritePageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> favoriteList = ref.watch(favoriListesiProvider);
    AsyncValue<List<Restorantlar>> restoranList = ref.watch(restoranFutureProvider);
    AsyncValue<List<Oteller>> otelList = ref.watch(otelFutureProvider);
    PageController _pageController = PageController(); // PageController'ı tanımlıyoruz
    double ekranGenisligi = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar:PreferredSize(preferredSize: Size.fromHeight(ekranGenisligi/10),child: const CustomAppBar()),
      body: Column(
        children: <Widget>[
          // Butonlar
          Flexible(
            child: Row(
              children: <Widget>[
                // Restoranlar butonu
                Expanded(
                  child: CustomRestoranButton(pageController: _pageController),
                ),
                // Oteller butonu
                Expanded(
                  child: CustomOtelButton(pageController: _pageController),
                ),
              ],
            ),
          ),
          // Sayfa geçişi
          Flexible(
            flex: 20,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController, // PageController ile kontrol ediliyor
              children: <Widget>[
                // Sayfa 1 (Restoranlar)
                Container(
                  child: restoranList.when(
                    data: (List<Restorantlar> restoranListe) {
                      List<Restorantlar> filteredRestoranList =favoriteList.isEmpty?<Restorantlar>[]: restoranListe.where((Restorantlar restoran) => favoriteList.contains(restoran.restoran_ad)).toList();
                      return filteredRestoranList.isEmpty ?const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              InfoCard(title: 'restoran',),
                          ],
                        ),
                      )
                          :FavoriRestoranKartlar(filteredRestoranList: filteredRestoranList);
                    },
                    error: (Object error, StackTrace stackTrace) => Center(child: Text(error.toString())),
                    loading: () => const Center(child: CircularProgressIndicator()),
                  ),
                ),
                // Sayfa 2 (Oteller)
                Container(
                  child: otelList.when(
                    data: (List<Oteller> otelListe) {List<Oteller> filteredOtelList =favoriteList.isEmpty?<Oteller>[]: otelListe.where((Oteller otel) => favoriteList.contains(otel.otel_ad)).toList();
                    return filteredOtelList.isEmpty ?const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InfoCard(title: 'otel'),
                        ],
                      ),
                    )
                        : FavoriOtelKartlar(filteredOtelList: filteredOtelList);
                    },
                    error: (Object error, StackTrace stackTrace) => Center(child: Text(error.toString())),
                    loading: () => const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
