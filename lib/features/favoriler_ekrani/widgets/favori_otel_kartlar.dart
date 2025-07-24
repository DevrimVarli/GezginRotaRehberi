import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_favorite_button.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_image_card.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_star_icon.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_text_name.dart';
class FavoriOtelKartlar extends ConsumerWidget {
  const FavoriOtelKartlar({super.key,required this.filteredOtelList});
  final List<dynamic> filteredOtelList;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ListView.builder(
      itemCount: filteredOtelList.length,
      itemBuilder: (BuildContext context, int index) {
        var otel = filteredOtelList[index];
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: <Widget>[

              CustomImageCard(mekan_resim: otel.otel_resim.toString(),),
              CustomStarIcon(mekan_puan: otel.otel_yildiz.toString(),),
              CustomTextName(mekan_ad: otel.otel_ad.toString(),),
              CustomFavoriteButton(mekan_ad: otel.otel_ad.toString(),),

            ],
          ),
        );
      },
    );
  }
}
