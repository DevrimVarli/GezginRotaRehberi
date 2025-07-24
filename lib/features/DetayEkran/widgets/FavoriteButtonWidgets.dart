import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yeni_tasarim/providers/all_providers.dart';

class FavoriteButtonWidgets extends ConsumerWidget {

  const FavoriteButtonWidgets({
    super.key,
    required this.mekanAdi,
  });
  final String mekanAdi;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    bool isFavori = ref.watch(favoriListesiProvider).contains(mekanAdi);

    return Positioned(
      bottom: -20,
      right: 20,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: colorScheme.surface, // tema uyumlu arka plan
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(
            Icons.favorite,
            color: isFavori ? colorScheme.primary : colorScheme.outlineVariant,
            size: 30,
          ),
          onPressed: () {
            StateController<List<String>> favoriNotifier = ref.read(favoriListesiProvider.notifier);
            List<String> currentList = <String>[...favoriNotifier.state];

            if (isFavori) {
              currentList.remove(mekanAdi);
            } else {
              currentList.add(mekanAdi);
            }

            favoriNotifier.state = currentList;
          },
        ),
      ),
    );
  }
}
