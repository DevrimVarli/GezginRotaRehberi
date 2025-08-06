import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/app_bar_widgets.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/arama_text_field_widgets.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/kategori_widgets.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/restorant_list_view_widgets.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/oteller_list_view_widgets.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';

/// Uygulamanın ana ekranı.
/// - Arama alanı
/// - Kategori seçimi
/// - Restoran veya otel listeleri
class AnaEkran extends ConsumerWidget {
  const AnaEkran({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tema renkleri
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Seçili kategori index'i
    int selectedIndex = ref.watch(selectedIndexProvider);

    // Kategori başlıkları
    List<String> basliklar = ref.watch(kategoriFutureProvider);

    // Ekran yüksekliği (AppBar boyutunu belirlemek için)
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;

    // Kategoriye göre gösterilecek widget
    Widget categoryWidget;

    if (basliklar[selectedIndex].tr() == 'Hotels' ||
        basliklar[selectedIndex].tr() == 'Oteller') {
      // Sadece oteller listesi
      categoryWidget = const OtellerListViewWidget();
    } else if (basliklar[selectedIndex].tr() == 'Restaurants' ||
        basliklar[selectedIndex].tr() == 'Restoranlar') {
      // Sadece restoranlar listesi
      categoryWidget = const RestorantListViewWidget();
    } else {
      // Hem restoran hem otel listesi
      categoryWidget = const Column(
        children: <Widget>[RestorantListViewWidget(), OtellerListViewWidget()],
      );
    }
    Box<String> box = Hive.box<String>('aramaSonuclari');

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ekranYuksekligi / 10),
        child: const AppBarWidget(),
      ),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: <Widget>[
            // Arama alanı
            const SliverToBoxAdapter(child: AramaTextFieldWidget()),
            /*SliverToBoxAdapter(
             child: ValueListenableBuilder<Box<String>>(
              valueListenable: box.listenable(),
               builder: (BuildContext context, Box<String> value, Widget? child){
                Iterable<String>aramaSonuclari = value.values.toList().reversed;
                return  SizedBox(
                 height: 50,
                 child: ListView.builder(
                 scrollDirection: Axis.horizontal,
                 itemCount: aramaSonuclari.length,
                 itemBuilder: (context, index) {
                 return Padding(
                   padding: const EdgeInsets.all(8),
                   child: Row(
                     children: [
                       Text(aramaSonuclari.elementAt(index)),
                       if(box.values.toList().isNotEmpty) IconButton(onPressed: (){box.delete(aramaSonuclari.elementAt(index));}, icon: const Icon(Icons.delete))
                     ],
                   ),
                 );
                 },
                 ),
                 );
               },
             ),


            ),*/

            // Kategori seçim alanı
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: KategoriWidget(),
              ),
            ),
            // İçerik
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: categoryWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
