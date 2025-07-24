import 'package:flutter/material.dart';
class CustomImageCard extends StatelessWidget {
  CustomImageCard({super.key, required this.mekan_resim});
  String mekan_resim;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(mekan_resim),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
