import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/AppBarWidget.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/AramaTextFieldWidget.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/KategoriWidget.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/RestorantListViewWidget.dart';
import '../features/AnaEkran/widgets/OtellerListViewWidget.dart';
import '../providers/all_providers.dart';

class AnaEkran extends ConsumerWidget {
  const AnaEkran({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final selectedIndex = ref.watch(selectedIndexProvider);
    final basliklar = ref.watch(kategoriFutureProvider);
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;

    Widget categoryWidget;

    if (basliklar[selectedIndex] == "Hotels") {
      categoryWidget = OtellerListViewWidget();
    } else if (basliklar[selectedIndex] == "Food") {
      categoryWidget = RestorantListViewWidget();
    } else {
      categoryWidget = Column(
        children: [
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
          slivers: [
            // Arama alanı sabit kalsın
            SliverToBoxAdapter(
              child: AramaTextFieldWidget(),
            ),
            // Kategori alanı sabit kalsın
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 8),
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
