import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_favorite_button.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_image_card.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_star_icon.dart';
import 'package:yeni_tasarim/features/favoriler_ekrani/widgets/custom_text_name.dart';
import 'package:yeni_tasarim/model/oteller.dart';
class FavoriOtelKartlar extends ConsumerWidget {
  const FavoriOtelKartlar({super.key,required this.filteredOtelList});
  final List<Oteller> filteredOtelList;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ListView.builder(
      itemCount: filteredOtelList.length,
      itemBuilder: (BuildContext context, int index) {
        Oteller otel = filteredOtelList[index];
        return Padding(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            child: Stack(
              children: <Widget>[
            
                CustomImageCard(mekanResim: otel.otelResim,),
                CustomStarIcon(mekanPuan: otel.otelYildiz.toString(),),
                CustomTextName(mekanAd: otel.otelAd,),
                CustomFavoriteButton(mekanAd: otel.otelAd),
            
              ],
            ),
          ),
        );
      },
    );
  }
}
