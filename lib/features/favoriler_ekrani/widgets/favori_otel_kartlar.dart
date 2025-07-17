import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../providers/all_providers.dart';
import 'custom_favorite_button.dart';
import 'custom_image_card.dart';
import 'custom_star_icon.dart';
import 'custom_text_name.dart';
class FavoriOtelKartlar extends ConsumerWidget {
  final List<dynamic> filteredOtelList;
  const FavoriOtelKartlar({super.key,required this.filteredOtelList});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ListView.builder(
      itemCount: filteredOtelList.length,
      itemBuilder: (context, index) {
        final otel = filteredOtelList[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [

              CustomImageCard(mekan_resim: otel.otel_resim,),
              CustomStarIcon(mekan_puan: otel.otel_yildiz.toString(),),
              CustomTextName(mekan_ad: otel.otel_ad,),
              CustomFavoriteButton(mekan_ad: otel.otel_ad,),

            ],
          ),
        );
      },
    );
  }
}
