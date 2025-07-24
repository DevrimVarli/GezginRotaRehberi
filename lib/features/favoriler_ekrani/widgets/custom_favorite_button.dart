import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yeni_tasarim/providers/all_providers.dart';
class CustomFavoriteButton extends ConsumerWidget {
  CustomFavoriteButton({super.key,required this.mekan_ad});
  String mekan_ad;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Positioned(
        bottom: 5,
        right: 10,
        child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.white,
            ),

            child:IconButton(onPressed: (){
              StateController<List<String>> favoriNotifier = ref.read(favoriListesiProvider.notifier);
              List<String> currentList = <String>[...favoriNotifier.state] // yeni referans oluştur
              ..remove(mekan_ad); // elemanı çıkar
              favoriNotifier.state = currentList;
            }, icon: const Icon(Icons.favorite,color: Colors.blue,),),
        ),
    );
  }
}
