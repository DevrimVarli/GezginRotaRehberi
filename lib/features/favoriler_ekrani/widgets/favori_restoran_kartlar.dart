import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_favorite_button.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_star_icon.dart';
import '../../../providers/all_providers.dart';
import 'custom_image_card.dart';
import 'custom_text_name.dart';
class FavoriRestoranKartlar extends ConsumerWidget {
  final List<dynamic> filteredRestoranList;
  FavoriRestoranKartlar({required this.filteredRestoranList});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return  ListView.builder(
      itemCount: filteredRestoranList.length,
      itemBuilder: (context, index) {
        final restoran = filteredRestoranList[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
             CustomImageCard(mekan_resim: restoran.restoran_resim,),
              CustomStarIcon(mekan_puan: restoran.restoran_puan,),
              CustomTextName(mekan_ad: restoran.restoran_ad,),
              CustomFavoriteButton(mekan_ad: restoran.restoran_ad,),

            ],
          ),
        );
      },
    );
  }
}
