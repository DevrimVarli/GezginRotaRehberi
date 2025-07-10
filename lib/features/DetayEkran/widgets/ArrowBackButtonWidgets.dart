import 'package:flutter/material.dart';
class ArrowBackButtonWidgets extends StatelessWidget {
  const ArrowBackButtonWidgets({super.key});
//Geri Dönüş Butonu Yapıldı
  @override
  Widget build(BuildContext context) {
    return  Positioned(
      top: 20,
      left: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 40,
          width: 40,
          color: Colors.white,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 18, color: Colors.grey),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
