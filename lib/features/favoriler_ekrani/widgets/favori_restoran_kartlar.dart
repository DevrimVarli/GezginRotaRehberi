import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_favorite_button.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_image_card.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_star_icon.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_text_name.dart';
import 'package:yeni_tasarim/model/restorantlar.dart';

class FavoriRestoranKartlar extends ConsumerWidget {
  const FavoriRestoranKartlar({super.key, required this.filteredRestoranList});

  // Filtrelenmiş restoran listesi
  final List<Restorantlar> filteredRestoranList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: filteredRestoranList.length, // Restoranların sayısı
      itemBuilder: (BuildContext context, int index) {
        Restorantlar restoran =
            filteredRestoranList[index]; // Filtrelenmiş listeden restoranı alıyoruz

        return Padding(
          padding: const EdgeInsets.all(
            8,
          ), // Kartlar arasında boşluk bırakıyoruz
          child: Stack(
            children: <Widget>[
              // Restoran resmini gösteren kart
              CustomImageCard(mekanResim: restoran.restoranResim),
              // Restoranın puanını gösteren yıldız ikonu
              CustomStarIcon(mekanPuan: restoran.restoranPuan),
              // Restoranın adını gösteren metin
              CustomTextName(mekanAd: restoran.restoranAd),
              // Favori butonu
              CustomFavoriteButton(mekanAd: restoran.restoranAd),
            ],
          ),
        );
      },
    );
  }
}
