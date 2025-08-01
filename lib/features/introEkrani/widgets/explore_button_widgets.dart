import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
// EXPLORE BUTONU
import 'package:yeni_tasarim/screens/bottom_navigation_bar_screen.dart';

class ExploreButtonWidget extends StatelessWidget {
  const ExploreButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Ekranın boyutlarını alıyoruz
    double ekranYuksekligi = MediaQuery.of(context).size.height;
    double ekranGenisligi = MediaQuery.of(context).size.width;

    return Positioned(
      bottom: 50, // Ekranın alt kısmından 50 birim yukarıda
      left: 32, // Ekranın sol kısmından 32 birim sağda
      child: SizedBox(
        width: ekranGenisligi / 1.21, // Butonun genişliği, ekranın %80'ine ayarlanmış
        height: ekranYuksekligi / 20, // Butonun yüksekliği, ekranın 20'de biri kadar
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: HexColor('#176FF2'), // Butonun arka plan rengi, HexColor ile belirleniyor
            shape: const RoundedRectangleBorder(
              // Butonun kenarlarını yuvarlatmak için
            ),
          ),
          onPressed: () {
            // Butona tıklanıldığında yapılacak işlem
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<Widget>(
                builder: (BuildContext context) => const Secim(), // "Secim" sayfasına geçiş
              ),
            );
          },
          child: Text(
            'Explore', // Buton metni
            style: GoogleFonts.montserrat(
              fontSize: 24, // Yazı boyutu
              color: Colors.white, // Yazı rengi beyaz
              fontWeight: FontWeight.bold, // Yazı kalınlığı
            ),
          ),
        ),
      ),
    );
  }
}
