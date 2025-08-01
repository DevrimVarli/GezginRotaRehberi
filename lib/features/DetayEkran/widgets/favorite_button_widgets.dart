import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';

class FavoriteButtonWidgets extends ConsumerStatefulWidget {
  const FavoriteButtonWidgets({
    super.key,
    required this.mekanAdi, // Favori yapılacak mekan adı
  });
  final String mekanAdi;

  @override
  ConsumerState<FavoriteButtonWidgets> createState() => _FavoriteButtonWidgetsState();
}

class _FavoriteButtonWidgetsState extends ConsumerState<FavoriteButtonWidgets> {

  @override
  Widget build(BuildContext context) {
    // Favori mekanlar için Hive box'ı kullanıyoruz
    Box<String> box = ref.watch(favorilerProvider);

    // Tema renk düzeni
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Positioned(
      bottom: -20, // Ekranın alt kısmına konumlandırıyoruz
      right: 20, // Ekranın sağ kısmına konumlandırıyoruz
      child: Container(
        width: 60, // Butonun genişliği
        height: 60, // Butonun yüksekliği
        decoration: BoxDecoration(
          color: colorScheme.surface, // Arka plan rengini temadan alıyoruz
          shape: BoxShape.circle, // Yuvarlak şekil
          boxShadow: <BoxShadow>[
            // Butona gölge ekliyoruz
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 4), // Gölge kayması
            ),
          ],
        ),
        child: ValueListenableBuilder<Box<String>>(
          // Favoriler box'ındaki değişiklikleri dinliyoruz
          valueListenable: box.listenable(),
          builder: (BuildContext context, Box<String> favoriBox, _) {
            // Mekan favoriye eklenmiş mi?
            bool isFavori = favoriBox.values.contains(widget.mekanAdi);

            return IconButton(
              onPressed: () {
                // Butona tıklanırsa, mekan adı favorilerden eklenir ya da çıkarılır
                if (isFavori) {
                  box.delete(widget.mekanAdi); // Favorilerden çıkar
                } else {
                  box.put(widget.mekanAdi, widget.mekanAdi); // Favorilere ekle
                }
              },
              icon: Icon(
                Icons.favorite, // Favori ikonunu kullanıyoruz
                color: isFavori ? colorScheme.primary : colorScheme.onSurface, // Renk temaya göre
              ),
            );
          },
        ),
      ),
    );
  }
}
