import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yeni_tasarim/providers/all_providers.dart';

class KategoriWidget extends ConsumerWidget {
  const KategoriWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tema renk düzenini almak için kullanılan değişken
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    // selectedIndexProvider'dan seçili olan kategori indeksini alıyoruz
    int selectedIndex = ref.watch(selectedIndexProvider);

    // kategoriFutureProvider'dan kategori başlıklarını alıyoruz
    List<String> basliklar = ref.watch(kategoriFutureProvider);

    return SizedBox(
      height: 50, // Kategori widget'ının yüksekliği
      child: ListView.builder(
        // Listeyi yatay şekilde kaydırmak için scrollDirection'u Axis.horizontal olarak ayarlıyoruz
        scrollDirection: Axis.horizontal,
        itemCount: basliklar.length, // Liste öğe sayısı
        itemBuilder: (BuildContext context, int index) {
          // Seçili kategoriyi kontrol etmek için isSelected değişkenini oluşturuyoruz
          bool isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              // Kategoriye tıklanırsa, seçili kategori indeksini güncelliyoruz
              ref.read(selectedIndexProvider.notifier).state = index;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // İçerik padding
              decoration: BoxDecoration(
                // Seçili kategoriye farklı renk uygulanacak
                color: isSelected ? colorScheme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(32), // Yuvarlatılmış köşeler
              ),
              child: Text(
                basliklar[index], // Kategori başlığı
                style: TextStyle(
                  fontWeight: FontWeight.w600, // Yazı kalınlığı
                  fontSize: 16, // Yazı boyutu
                  color: isSelected
                      ? colorScheme.onPrimary // Seçili kategorinin yazı rengi
                      : colorScheme.primary, // Seçili olmayan kategorinin yazı rengi
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
