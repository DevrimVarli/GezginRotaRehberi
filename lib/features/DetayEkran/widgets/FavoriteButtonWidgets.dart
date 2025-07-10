import 'package:flutter/material.dart';
class FavoriteButtonWidgets extends StatelessWidget {
  const FavoriteButtonWidgets({super.key});
//Favori Butonu Yapıldı
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -20,
      right: 20,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(Icons.favorite, color: Colors.red, size: 30),
          onPressed: () {},
        ),
      ),
    );
  }
}
