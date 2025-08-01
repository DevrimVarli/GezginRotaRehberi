import 'package:flutter/material.dart';

class BaslikTextWidget extends StatelessWidget {
  const BaslikTextWidget({super.key});

  // BAŞLIK GÖSTERİLİYOR
  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 93, // Ekranın üst kısmından 93 birim yukarıda
      left: 53, // Ekranın sol kısmından 53 birim sağda
      child: Text(
        'Aspen', // Gösterilecek başlık metni
        style: TextStyle(
          fontFamily: 'Hiatus', // Yazı tipi ailesi
          color: Colors.white, // Yazı rengi beyaz
          fontSize: 150, // Yazı boyutu
        ),
      ),
    );
  }
}
