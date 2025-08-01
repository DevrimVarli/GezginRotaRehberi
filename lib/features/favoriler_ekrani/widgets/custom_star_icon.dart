import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStarIcon extends StatelessWidget {

  const CustomStarIcon({super.key, required this.mekanPuan});

  final String mekanPuan; // Bu parametre, gösterilecek mekanın puanını içerir.

  @override
  Widget build(BuildContext context) {
    // Tema renk düzenini almak için kullanılan değişken
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Positioned(
      top: 10, // Ekranın üst kısmından 10 birim uzaklıkta
      right: 10, // Ekranın sağ kısmından 10 birim uzaklıkta
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // İçeriğe yatay ve dikey padding ekliyoruz
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.8), // Arka plan rengini temadan alıyoruz, %80 opaklık
          borderRadius: BorderRadius.circular(8), // Yuvarlatılmış köşeler
        ),
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.star, // Yıldız ikonu
              color: Colors.amber, // Yıldız rengi
              size: 20, // Yıldız boyutu
            ),
            const SizedBox(width: 4), // Yıldız ve puan arasına boşluk ekliyoruz
            Text(
              mekanPuan, // Mekanın puanı
              style: GoogleFonts.montserrat(
                fontSize: 16, // Yazı boyutu
                color: colorScheme.onSurface, // Yazı rengi temaya uyumlu
                fontWeight: FontWeight.w500, // Yazı kalınlığı
              ),
            ),
          ],
        ),
      ),
    );
  }
}
