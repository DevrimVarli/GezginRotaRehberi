import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/all_providers.dart';
class CustomFavoriteButton extends ConsumerWidget {
  String mekan_ad;
  CustomFavoriteButton({super.key,required this.mekan_ad});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Positioned(
        bottom: 5,
        right: 10,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.white,
            ),

            child:IconButton(onPressed: (){
              final favoriNotifier = ref.read(favoriListesiProvider.notifier);
              final currentList = [...favoriNotifier.state]; // yeni referans oluştur
              currentList.remove(mekan_ad); // elemanı çıkar
              favoriNotifier.state = currentList;
            }, icon: Icon(Icons.favorite,color: Colors.blue,))
        )
    );
  }
}
