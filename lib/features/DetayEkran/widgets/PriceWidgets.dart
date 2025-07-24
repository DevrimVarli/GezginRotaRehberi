import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:yeni_tasarim/model/Restorantlar.dart';
import 'package:yeni_tasarim/model/oteller.dart';

class PriceWidgets extends StatelessWidget {

  const PriceWidgets({
    super.key,
    this.secilenOtel,
    this.secilenRestorant,
    required this.ekranGenisligi,
  });
  final Oteller? secilenOtel;
  final Restorantlar? secilenRestorant;
  final double ekranGenisligi;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: ekranGenisligi,
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: colorScheme.surface, // zemin temadan
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Price Texts
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Price',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                secilenOtel != null
                    ? '€${secilenOtel!.otel_fiyat}'
                    : '€${secilenRestorant!.restoran_fiyat}',
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
                'Book Now →',
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
