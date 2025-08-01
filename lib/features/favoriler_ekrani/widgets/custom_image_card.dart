import 'package:flutter/material.dart';

class CustomImageCard extends StatelessWidget {
  const CustomImageCard({super.key, required this.mekanResim});

  final String mekanResim; // Kartta gösterilecek mekanın resmi

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250, // Kartın yüksekliği
      width: double.infinity, // Kartın genişliği, ekran genişliğine uyacak şekilde
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16), // Yuvarlatılmış köşeler
        image: DecorationImage(
          image: NetworkImage(mekanResim), // Mekan resmini internetten alıyoruz
          fit: BoxFit.cover, // Resmin, kartın tamamını kaplamasını sağlıyoruz
        ),
      ),
    );
  }
}
