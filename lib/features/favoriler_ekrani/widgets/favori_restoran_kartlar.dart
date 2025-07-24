import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_favorite_button.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_star_icon.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_image_card.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_text_name.dart';
class FavoriRestoranKartlar extends ConsumerWidget {
  const FavoriRestoranKartlar({super.key, required this.filteredRestoranList});
  final List<dynamic> filteredRestoranList;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return  ListView.builder(
      itemCount: filteredRestoranList.length,
      itemBuilder: (BuildContext context, int index) {
        var restoran = filteredRestoranList[index];
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: <Widget>[
             CustomImageCard(mekan_resim: restoran.restoran_resim.toString(),),
              CustomStarIcon(mekan_puan: restoran.restoran_puan.toString(),),
              CustomTextName(mekan_ad: restoran.restoran_ad.toString(),),
              CustomFavoriteButton(mekan_ad: restoran.restoran_ad.toString(),),

            ],
          ),
        );
      },
    );
  }
}
