import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/detail_screen.dart';
class RestoranSliver extends ConsumerWidget {
  const RestoranSliver({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    AsyncValue<List<Restorantlar>> restoranList = ref.watch(restoranFutureProvider);
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;
    double ekranGenisligi = MediaQuery.sizeOf(context).width;
    return restoranList.when(
        data: (List<Restorantlar> restoranListe) => SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index){
              Restorantlar restorant = restoranListe[index];
              return Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 8,vertical:8 ),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute<Widget>(builder: (BuildContext context)=>DetayEkrani(secilenRestorant: restorant)));
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: ekranYuksekligi/4,
                        width: ekranGenisligi, // Genişliği sabitle
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: NetworkImage(restorant.restoranResim),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: ekranYuksekligi/4,
                        width: ekranGenisligi, // Genişliği sabitle
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: <Color>[
                              Colors.black.withValues(alpha: 0.17),
                              Colors.transparent,
                            ],
                          ),                              ),
                      ),
                      Positioned(
                        left: 5,
                        top: 10,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: colorScheme.surface.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  restorant.restoranAd,
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
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 18,
                                ),
                                Text(
                                  restorant.restoranPuan,
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 5,
                          right: 10,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color:colorScheme.surface.withValues(alpha: 0.85),
                              ),

                              child:IconButton(onPressed: (){
                                StateController<List<String>> favoriNotifier = ref.read(favoriListesiProvider.notifier);
                                List<String> currentList = <String>[...favoriNotifier.state];

                                if (currentList.contains(restorant.restoranAd)) {
                                  currentList.remove(restorant.restoranAd);
                                } else {
                                  currentList.add(restorant.restoranAd);
                                }

                                favoriNotifier.state = currentList;
                              }, icon: Icon(Icons.favorite,color:ref.watch(favoriListesiProvider).contains(restorant.restoranAd)
                                  ? colorScheme.primary
                                  : colorScheme.onSurface,),),
                          ),
                      ),


                    ],
                  ),
                ),
              );
            },
            childCount: restoranListe.length,
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
