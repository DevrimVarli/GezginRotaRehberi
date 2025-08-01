import 'package:flutter/material.dart';

class ArrowBackButtonWidgets extends StatelessWidget {
  const ArrowBackButtonWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    // Tema renk düzenini alıyoruz
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Positioned(
      top: 20, // Ekranın üst kısmından 20 birim uzaklıkta
      left: 20, // Ekranın sol kısmından 20 birim uzaklıkta
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10), // Butonun köşelerini yuvarlıyoruz
        child: Container(
          height: 40, // Butonun yüksekliği
          width: 40,  // Butonun genişliği
          color: colorScheme.surface, // Arka plan rengini temadan alıyoruz
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios, // Geri ok simgesi
              size: 18, // İkon boyutu
              color: colorScheme.onSurface, // İkon rengini temadan alıyoruz
            ),
            onPressed: () {
              // Butona tıklanması durumunda bir önceki sayfaya geri dönüyoruz
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
