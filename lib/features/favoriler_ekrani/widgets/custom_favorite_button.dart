import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
class CustomFavoriteButton extends ConsumerWidget {
  const CustomFavoriteButton({super.key,required this.mekanAd});
  final String mekanAd;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    Box<String> box = ref.watch(favorilerProvider);
    return Positioned(
        bottom: 5,
        right: 10,
        child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.white,
            ),


            child:ValueListenableBuilder<Box<String>>(
              valueListenable: box.listenable(),
              builder: (BuildContext context, Box<String> value, Widget? child) {
                return IconButton(onPressed: (){
                   box.delete(mekanAd);

                }, icon: const Icon(Icons.favorite,color: Colors.blue,),);

              },

            ),
        ),
    );
  }
}
