import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_tasarim/model/oteller.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/detail_screen.dart';

class OtelSliver extends ConsumerWidget {
  const OtelSliver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Oteller>> otelList = ref.watch(otelFutureProvider);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;
    double ekranGenisligi = MediaQuery.sizeOf(context).width;

    return otelList.when(
      data: (List<Oteller> otelListe) => SliverList(
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            Oteller otel = otelListe[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(builder: (BuildContext context) => DetayEkrani(secilenOtel: otel)),
                  );
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: ekranYuksekligi / 4,
                      width: ekranGenisligi,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(otel.otelResim),
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
                          colors: <Color>[
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
                          otel.otelAd,
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
                          children: <Widget>[
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            Text(
                              otel.otelYildiz.toString(),
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
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: colorScheme.surface.withValues(alpha: 0.85),
                        ),
                        child: IconButton(
                          onPressed: () {
                            StateController<List<String>> favoriNotifier = ref.read(favoriListesiProvider.notifier);
                            List<String> currentList = <String>[...favoriNotifier.state];

                            if (currentList.contains(otel.otelAd)) {
                              currentList.remove(otel.otelAd);
                            } else {
                              currentList.add(otel.otelAd);
                            }

                            favoriNotifier.state = currentList;
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: ref.watch(favoriListesiProvider).contains(otel.otelAd)
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
      error: (Object error, StackTrace stackTrace) => SliverFillRemaining(
        child: Center(child: Text(error.toString())),
      ),
      loading: () => const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
