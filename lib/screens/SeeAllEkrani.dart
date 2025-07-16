import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_tasarim/features/SeeAllEkran/widgets/otel_sliver.dart';
import '../features/SeeAllEkran/widgets/restoran_sliver.dart';
import '../providers/all_providers.dart';

class SeeAllEkrani extends ConsumerWidget {
  const SeeAllEkrani({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restoranList = ref.watch(restoranFutureProvider);
    final otelList = ref.watch(otelFutureProvider);
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;
    double ekranGenisligi = MediaQuery.sizeOf(context).width;

    return Scaffold(
      
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Restoranlar bölümü
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(textAlign: TextAlign.center,
                  "Restoranlar",
                  style: GoogleFonts.roboto(fontSize: 24,fontWeight: FontWeight.bold),
                ),
              ),
            ),
            RestoranSliver(),
        
            // Oteller bölümü
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Oteller",
                  style: GoogleFonts.roboto(fontSize: 24,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
           OtelSliver()
          ],
        ),
      ),
    );
  }
}