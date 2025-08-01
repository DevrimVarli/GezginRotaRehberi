import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_favorite_button.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_image_card.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_star_icon.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_text_name.dart';
import 'package:yeni_tasarim/model/oteller.dart';

class FavoriOtelKartlar extends ConsumerWidget {
  const FavoriOtelKartlar({super.key, required this.filteredOtelList});

  // Filtrelenmiş otel listesi
  final List<Oteller> filteredOtelList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: filteredOtelList.length, // Liste eleman sayısı
      itemBuilder: (BuildContext context, int index) {
        Oteller otel = filteredOtelList[index]; // Filtrelenmiş listeden otel alınır
        return Padding(
          padding: const EdgeInsets.all(8), // Kartlar arasında boşluk bırakıyoruz
          child: GestureDetector(
            child: Stack(
              children: <Widget>[
                // Otel resmi, yıldız ikonu, otel adı ve favori butonunu içeren kartlar
                CustomImageCard(mekanResim: otel.otelResim), // Otel resmini gösteren widget
                CustomStarIcon(mekanPuan: otel.otelYildiz.toString()), // Yıldız puanını gösteren widget
                CustomTextName(mekanAd: otel.otelAd), // Otel ismini gösteren widget
                CustomFavoriteButton(mekanAd: otel.otelAd), // Favori butonu
              ],
            ),
          ),
        );
      },
    );
  }
}
