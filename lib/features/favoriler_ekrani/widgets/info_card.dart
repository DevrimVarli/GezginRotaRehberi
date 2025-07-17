import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../screens/SeeAllEkrani.dart';
class InfoCard extends StatelessWidget {
  final String title;
  const InfoCard({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.favorite_border,
            color: Colors.blue,
            size: 72,
          ),
          const SizedBox(height: 20),
          Text(
            "Favori ${title} bulunamadı",
            style: GoogleFonts.montserrat(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "Henüz hiçbir ${title} favorilere eklemediniz.\nKeşfetmeye başlayın!",
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SeeAllEkrani()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            icon: Icon(Icons.search, color: Colors.white),
            label: Text(
              "Keşfet",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
