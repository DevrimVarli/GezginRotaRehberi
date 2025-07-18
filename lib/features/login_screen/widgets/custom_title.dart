import 'package:flutter/material.dart';
class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 93,
        left: 53,
        child: Text("Aspen",style: TextStyle(
          fontFamily: "Hiatus",
          color: Colors.white,
          fontSize: 150,
        ),));
  }
}
