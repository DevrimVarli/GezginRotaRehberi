import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/all_providers.dart';
class KategoriWidget extends ConsumerWidget {
  KategoriWidget();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final colorScheme=Theme.of(context).colorScheme;
    final selectedIndex=ref.watch(selectedIndexProvider);
    final basliklar=ref.watch(kategoriFutureProvider);
    return  SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: basliklar.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
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
    );;
  }
}
