import 'package:flutter/material.dart';

import 'package:yeni_tasarim/screens/home_screen.dart';
import 'package:yeni_tasarim/screens/favorite_page_view.dart';
import 'package:yeni_tasarim/screens/account_and_login_screen.dart';

/// Alt menü (BottomNavigationBar) ile sayfa geçişlerini yöneten ana yapı
class Secim extends StatefulWidget {
  const Secim({super.key});

  @override
  State<Secim> createState() => _SecimState();
}

class _SecimState extends State<Secim> {
  /// Başlangıçta gösterilecek sayfa index'i
  /// Genelde 0 (Ana ekran) olur. Şu an 3 olduğu için uygulama ilk açılışta Profil ekranını açıyor.
  int secilenIndex = 0;

  /// Alt menüdeki sayfaların listesi
  final List<Widget> sayfaListesi = <Widget>[
    const AnaEkran(),                // Home
    const AccountAndLoginScreen(),   // Search / Account
    const FavoritePageView(),        // Favorites
    const AccountAndLoginScreen(),   // Profile
  ];

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      /// Seçilen sekmeye karşılık gelen ekran
      body: sayfaListesi[secilenIndex],

      /// Alt menü
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(32),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: secilenIndex,
            onTap: (int index) {
              setState(() {
                secilenIndex = index;
              });
            },
            selectedItemColor: colorScheme.primary,
            unselectedItemColor: colorScheme.outlineVariant,
            backgroundColor: colorScheme.surface,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.mail),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.airplane_ticket_outlined),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
