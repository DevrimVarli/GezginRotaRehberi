import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yeni_tasarim/providers/all_providers.dart';
class KategoriWidget extends ConsumerWidget {
  const KategoriWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ColorScheme colorScheme=Theme.of(context).colorScheme;
    int selectedIndex=ref.watch(selectedIndexProvider);
    List<String> basliklar=ref.watch(kategoriFutureProvider);
    return  SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: basliklar.length,
        itemBuilder: (BuildContext context, int index) {
          bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              ref.read(selectedIndexProvider.notifier).state = index;
            },
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? colorScheme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Text(
                basliklar[index],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: isSelected ? colorScheme.onPrimary : colorScheme.primary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
