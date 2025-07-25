import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_favorite_button.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_star_icon.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_image_card.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_text_name.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';
class FavoriRestoranKartlar extends ConsumerWidget {
  const FavoriRestoranKartlar({super.key, required this.filteredRestoranList});
  final List<Restorantlar> filteredRestoranList;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return  ListView.builder(
      itemCount: filteredRestoranList.length,
      itemBuilder: (BuildContext context, int index) {
        Restorantlar restoran = filteredRestoranList[index];
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: <Widget>[
             CustomImageCard(mekanResim: restoran.restoranResim),
              CustomStarIcon(mekanPuan: restoran.restoranPuan),
              CustomTextName(mekanAd: restoran.restoranAd),
              CustomFavoriteButton(mekanAd: restoran.restoranAd),

            ],
          ),
        );
      },
    );
  }
}
