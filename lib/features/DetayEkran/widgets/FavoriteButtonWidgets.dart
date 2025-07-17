import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/all_providers.dart';
class FavoriteButtonWidgets extends ConsumerWidget {
  final String mekanAdi;
  const FavoriteButtonWidgets({super.key,required this.mekanAdi});
//Favori Butonu Yapıldı
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Positioned(
      bottom: -20,
      right: 20,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(Icons.favorite, color:ref.watch(favoriListesiProvider).contains(mekanAdi)?Colors.blue: Colors.grey, size: 30),
          onPressed: () {
            final favoriNotifier = ref.read(favoriListesiProvider.notifier);
            final currentList = [...favoriNotifier.state];
            ref.read(favoriListesiProvider).contains(mekanAdi)? currentList.remove(mekanAdi): currentList.add(mekanAdi); // yeni referans oluştur// elemanı çıkar
            favoriNotifier.state = currentList; // yeni listeyi ata → UI güncellenir

          },
        ),
      ),
    );
  }
}
