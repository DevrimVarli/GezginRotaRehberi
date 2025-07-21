import 'package:flutter/material.dart';
import 'package:yeni_tasarim/screens/home_screen.dart';
import 'package:yeni_tasarim/screens/favorite_page_view.dart';
import 'account_and_login_screen.dart';
import 'login_screen.dart';

class Secim extends StatefulWidget {
  const Secim({super.key});

  @override
  State<Secim> createState() => _SecimState();
}

class _SecimState extends State<Secim> {
  int secilenIndex = 0;

  final sayfaListesi = [
    AnaEkran(),
    AccountAndLoginScreen(),
    FavoritePageView(),
    AccountAndLoginScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: sayfaListesi[secilenIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface, // tema uyumlu arka plan
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
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
            onTap: (index) {
              setState(() {
                secilenIndex = index;
              });
            },
            selectedItemColor: colorScheme.primary,
            unselectedItemColor: colorScheme.outlineVariant,
            backgroundColor: colorScheme.surface,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.mail), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.airplane_ticket_outlined), label: "Search"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border), label: "Favorites"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
