import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';

class CustomFavoriteButton extends ConsumerWidget {
  const CustomFavoriteButton({super.key, required this.mekanAd});

  final String mekanAd; // Favori yapılacak mekanın adı

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Favori mekanları saklamak için Hive box'ı kullanıyoruz
    Box<String> box = ref.watch(favorilerProvider);

    return Positioned(
      bottom: 5, // Ekranın alt kısmına konumlandırıyoruz
      right: 10, // Ekranın sağ kısmına konumlandırıyoruz
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32), // Butonun yuvarlak köşeleri
          color: Colors.white, // Arka plan rengi
        ),
        child: ValueListenableBuilder<Box<String>>(
          valueListenable: box.listenable(), // Favorilerdeki değişiklikleri dinliyoruz
          builder: (BuildContext context, Box<String> value, Widget? child) {
            return IconButton(
              onPressed: () {
                // Butona tıklanırsa, ilgili mekan favorilerden silinir
                box.delete(mekanAd);
              },
              icon: const Icon(Icons.favorite, color: Colors.blue), // Favori simgesi
            );
          },
        ),
      ),
    );
  }
}
