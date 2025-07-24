import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/AppBarWidget.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/AramaTextFieldWidget.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/KategoriWidget.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/RestorantListViewWidget.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/OtellerListViewWidget.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';

class AnaEkran extends ConsumerWidget {
  const AnaEkran({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    int selectedIndex = ref.watch(selectedIndexProvider);
    List<String> basliklar = ref.watch(kategoriFutureProvider);
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;

    Widget categoryWidget;

    if (basliklar[selectedIndex] == 'Hotels') {
      categoryWidget = const OtellerListViewWidget();
    } else if (basliklar[selectedIndex] == 'Food') {
      categoryWidget = const RestorantListViewWidget();
    } else {
      categoryWidget = const Column(
        children: <Widget>[
          RestorantListViewWidget(),
          OtellerListViewWidget(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ekranYuksekligi / 10),
        child: AppBarWidget(ekranYuksekligi),
      ),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: <Widget>[
            // Arama alanı sabit kalsın
            const SliverToBoxAdapter(
              child: AramaTextFieldWidget(),
            ),
            // Kategori alanı sabit kalsın
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
                child: KategoriWidget(),
              ),
            ),
            // İçerik (scroll edilebilir)
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
