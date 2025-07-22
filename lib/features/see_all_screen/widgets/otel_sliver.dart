import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../providers/all_providers.dart';
import '../../../screens/detail_screen.dart';

class OtelSliver extends ConsumerWidget {
  const OtelSliver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otelList = ref.watch(otelFutureProvider);
    final colorScheme = Theme.of(context).colorScheme;
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;
    double ekranGenisligi = MediaQuery.sizeOf(context).width;

    return otelList.when(
      data: (otelListe) => SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final otel = otelListe[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetayEkrani(secilenOtel: otel)),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      height: ekranYuksekligi / 4,
                      width: ekranGenisligi,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(otel.otel_resim),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: ekranYuksekligi / 4,
                      width: ekranGenisligi,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.17),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 5,
                      top: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surface.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(
                          otel.otel_ad,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 10,
                      child: Container(
                        width: 60,
                        height: 30,

                        decoration: BoxDecoration(
                          color: colorScheme.surface.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 18),
                            Text(
                              otel.otel_yildiz.toString(),
                              style: GoogleFonts.roboto(
                                fontSize: 22,
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: colorScheme.surface.withValues(alpha: 0.85),
                        ),
                        child: IconButton(
                          onPressed: () {
                            final favoriNotifier = ref.read(favoriListesiProvider.notifier);
                            final currentList = [...favoriNotifier.state];

                            if (currentList.contains(otel.otel_ad)) {
                              currentList.remove(otel.otel_ad);
                            } else {
                              currentList.add(otel.otel_ad);
                            }

                            favoriNotifier.state = currentList;
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: ref.watch(favoriListesiProvider).contains(otel.otel_ad)
                                ? colorScheme.primary
                                : colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: otelListe.length,
        ),
      ),
      error: (error, stackTrace) => SliverFillRemaining(
        child: Center(child: Text(error.toString())),
      ),
      loading: () => const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
