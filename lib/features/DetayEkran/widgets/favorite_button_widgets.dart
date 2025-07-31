import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';

class FavoriteButtonWidgets extends ConsumerStatefulWidget {
  const FavoriteButtonWidgets({
    super.key,
    required this.mekanAdi,
  });
  final String mekanAdi;

  @override
  ConsumerState<FavoriteButtonWidgets> createState() => _FavoriteButtonWidgetsState();
}

class _FavoriteButtonWidgetsState extends ConsumerState<FavoriteButtonWidgets> {

  @override
  Widget build(BuildContext context) {
    Box<String> box = ref.watch(favorilerProvider);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
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
        child: ValueListenableBuilder<Box<String>>(
          valueListenable: box.listenable(),
          builder: (BuildContext context, Box<String> favoriBox, _) {
            bool isFavori = favoriBox.values.contains(widget.mekanAdi);

            return IconButton(
              onPressed: () {
                if (isFavori) {
                  box.delete(widget.mekanAdi);
                } else {
                  box.put(widget.mekanAdi, widget.mekanAdi);
                }
              },
              icon: Icon(
                Icons.favorite,
                color: isFavori ? colorScheme.primary : colorScheme.onSurface,
              ),
            );
          },
        ),

      ),
    );
  }
}
