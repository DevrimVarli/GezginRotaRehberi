import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MetinText extends StatelessWidget {
  const MetinText({super.key});

  // METİN GÖSTERİLİYOR
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 125, // Ekranın alt kısmından 125 birim yukarıda
      left: 32, // Ekranın sol kısmından 32 birim sağda
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Metinleri sola hizalar
        children: <Widget>[
          // "Plan your" metni
          Text(
            'Plan your',
            style: GoogleFonts.montserrat(
              fontSize: 36, // Yazı boyutu
              color: Colors.white, // Yazı rengi beyaz
            ),
          ),
          // "Luxurious" metni
          Text(
            'Luxurious',
            style: GoogleFonts.montserrat(
              fontSize: 48, // Yazı boyutu
              color: Colors.white, // Yazı rengi beyaz
              fontWeight: FontWeight.bold, // Yazı kalın
            ),
          ),
          // "Vacation" metni
          Text(
            'Vacation',
            style: GoogleFonts.montserrat(
              fontSize: 48, // Yazı boyutu
              color: Colors.white, // Yazı rengi beyaz
              fontWeight: FontWeight.bold, // Yazı kalın
            ),
          ),
        ],
      ),
    );
  }
}
