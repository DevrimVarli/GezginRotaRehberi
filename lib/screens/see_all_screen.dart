import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_tasarim/features/see_all_screen/widgets/otel_sliver.dart';
import 'package:yeni_tasarim/features/see_all_screen/widgets/restoran_sliver.dart';

class SeeAllEkrani extends ConsumerWidget {
  const SeeAllEkrani({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tema renkleri
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            // --- Restoranlar başlık alanı ---
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: <Widget>[
                    // Geri butonu
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(flex: 2),
                    // Başlık
                    Text(
                      'food'.tr(),
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
              ),
            ),

            // --- Restoran listesi ---
            const RestoranSliver(),

            // --- Oteller başlık alanı ---
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'hotels'.tr(),
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // --- Oteller listesi ---
            const OtelSliver(),
          ],
        ),
      ),
    );
  }
}
