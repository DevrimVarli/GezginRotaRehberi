import 'package:flutter/material.dart';
import 'package:yeni_tasarim/screens/AnaEkran.dart';
import 'package:yeni_tasarim/screens/favorite_page_view.dart';

class Secim extends StatefulWidget {
  const Secim({super.key});

  @override
  State<Secim> createState() => _SecimState();
}

class _SecimState extends State<Secim> {
  int secilenIndex = 0;
  var sayfaListesi = [
    AnaEkran(),
    AnaEkran(),
    FavoritePageView(),
    AnaEkran(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sayfaListesi[secilenIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, -2),
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
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white, // Container'dan geliyor
            showSelectedLabels: false, // ✅ Gösterilsin
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
