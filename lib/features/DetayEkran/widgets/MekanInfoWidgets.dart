import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/Restorantlar.dart';
import '../../../model/oteller.dart';

class MekanInfoWidgets extends StatelessWidget {
  final Oteller? secilenOtel;
  final Restorantlar? secilenRestorant;

  MekanInfoWidgets({super.key, this.secilenOtel, this.secilenRestorant});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 32.0, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık ve Harita Linki
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                secilenOtel != null
                    ? secilenOtel!.otel_ad
                    : secilenRestorant!.restoran_ad,
                style: GoogleFonts.montserrat(
                  fontSize: (secilenOtel != null
                      ? secilenOtel!.otel_ad.length
                      : secilenRestorant!.restoran_ad.length) >
                      20
                      ? 16
                      : 24,
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Show map",
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Puan ve yorum sayısı
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                secilenOtel != null
                    ? secilenOtel!.otel_yildiz.toString()
                    : secilenRestorant!.restoran_puan.toString(),
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: colorScheme.outlineVariant,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                "(355 Reviews)",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: colorScheme.outlineVariant,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Açıklama
          Text(
            secilenOtel != null
                ? secilenOtel!.otel_aciklama
                : secilenRestorant!.restoran_aciklama,
            style: GoogleFonts.roboto(
              fontSize: 18,
              color: colorScheme.onSurface,
            ),
          ),

          const SizedBox(height: 4),

          // "Read more" linki
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: Row(
              children: [
                Text(
                  "Read more",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: colorScheme.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
