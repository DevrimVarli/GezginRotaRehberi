import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../features/see_all_screen/widgets/otel_sliver.dart';
import '../features/see_all_screen/widgets/restoran_sliver.dart';

class SeeAllEkrani extends ConsumerWidget {
  const SeeAllEkrani({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
final colorScheme=Theme.of(context).colorScheme;
    return Scaffold(
      
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Restoranlar bölümü
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios,color:colorScheme.onSurfaceVariant ,)),
                    Spacer(flex: 2,),
                    Text(
                      "Restoranlar",
                      style: GoogleFonts.roboto(fontSize: 24,fontWeight: FontWeight.bold),
                    ),
                    Spacer(flex: 3,)
                  ],
                )
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