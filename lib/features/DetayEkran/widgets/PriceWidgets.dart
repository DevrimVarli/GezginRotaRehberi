import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/Restorantlar.dart';
import '../../../model/oteller.dart';

class PriceWidgets extends StatelessWidget {
  final Oteller? secilenOtel;
  final Restorantlar? secilenRestorant;
  final double ekranGenisligi;

  PriceWidgets({
    super.key,
    this.secilenOtel,
    this.secilenRestorant,
    required this.ekranGenisligi,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: ekranGenisligi,
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: colorScheme.surface, // zemin temadan
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Price Texts
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Price",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                secilenOtel != null
                    ? "€${secilenOtel!.otel_fiyat.toString()}"
                    : "€${secilenRestorant!.restoran_fiyat}",
                style: GoogleFonts.roboto(
                  fontSize: 32,
                  color: colorScheme.tertiary, // Öne çıkan fiyat rengi
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Book Now Button
          SizedBox(
            width: ekranGenisligi / 2,
            height: 60,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Book Now →",
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
