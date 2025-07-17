import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_app_bar.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/info_card.dart';
import 'package:yeni_tasarim/screens/home_screen.dart';
import 'package:yeni_tasarim/screens/see_all_screen.dart';

import '../features/favoriler_ekrani/widgets/custom_otel_button.dart';
import '../features/favoriler_ekrani/widgets/custom_restoran_button.dart';
import '../features/favoriler_ekrani/widgets/favori_otel_kartlar.dart';
import '../features/favoriler_ekrani/widgets/favori_restoran_kartlar.dart';
import '../providers/all_providers.dart';
import 'detail_screen.dart';

class FavoritePageView extends ConsumerWidget {
  const FavoritePageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteList = ref.watch(favoriListesiProvider);
    final restoranList = ref.watch(restoranFutureProvider);
    final otelList = ref.watch(otelFutureProvider);
    final PageController _pageController = PageController(); // PageController'ı tanımlıyoruz
    double ekranGenisligi = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar:PreferredSize(preferredSize: Size.fromHeight(ekranGenisligi/10),child: CustomAppBar()),
      body: Column(
        children: [
          // Butonlar
          Flexible(
            flex: 1,
            child: Row(
              children: [
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
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController, // PageController ile kontrol ediliyor
              children: [
                // Sayfa 1 (Restoranlar)
                Container(
                  child: restoranList.when(
                    data: (restoranListe) {
                      final filteredRestoranList =favoriteList.isEmpty?[]: restoranListe.where((restoran) => favoriteList.contains(restoran.restoran_ad)).toList();
                      return filteredRestoranList.isEmpty ?Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              InfoCard(title: "restoran",),
                          ],
                        ),
                      )
                          :FavoriRestoranKartlar(filteredRestoranList: filteredRestoranList);
                    },
                    error: (error, stackTrace) => Center(child: Text(error.toString())),
                    loading: () => Center(child: CircularProgressIndicator()),
                  ),
                ),
                // Sayfa 2 (Oteller)
                Container(
                  child: otelList.when(
                    data: (otelListe) {final filteredOtelList =favoriteList.isEmpty?[]: otelListe.where((otel) => favoriteList.contains(otel.otel_ad)).toList();
                    return filteredOtelList.isEmpty ?Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InfoCard(title: "otel")
                        ],
                      ),
                    )
                        : FavoriOtelKartlar(filteredOtelList: filteredOtelList);
                    },
                    error: (error, stackTrace) => Center(child: Text(error.toString())),
                    loading: () => Center(child: CircularProgressIndicator()),
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
