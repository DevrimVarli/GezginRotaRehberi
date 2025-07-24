import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:yeni_tasarim/model/Imkanlar.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';
import 'package:yeni_tasarim/model/oteller.dart';
class FacilitiesWidgets extends ConsumerWidget {

  const FacilitiesWidgets({
    super.key,
    required this.ekranGenisligi,
    this.secilenOtel,
    this.secilenRestorant,
  });
  final Oteller? secilenOtel;
  final Restorantlar? secilenRestorant;
  final double ekranGenisligi;

  Icon iconuBuL(String gelenVeri) {
    if (gelenVeri == 'wifi') {
      return const Icon(Icons.wifi);
    } else if (gelenVeri == 'hot_tub') {
      return const Icon(Icons.hot_tub);
    } else if (gelenVeri == 'pool') {
      return const Icon(Icons.pool);
    } else {
      return const Icon(Icons.lunch_dining);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Facilities',
          style: GoogleFonts.roboto(
            fontSize: 24,
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: (secilenOtel != null)
                ? secilenOtel!.imkanlar.length
                : secilenRestorant!.imkanlar.length,
            itemBuilder: (BuildContext context, int indeks) {
              Imkanlar imkan = (secilenOtel != null)
                  ? secilenOtel!.imkanlar[indeks]
                  : secilenRestorant!.imkanlar[indeks];

              return Container(
                width: ekranGenisligi / 4.6,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    iconuBuL(imkan.imkanIcon),
                    const SizedBox(height: 4),
                    Text(
                      imkan.imkanAdi,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
