import 'package:flutter/material.dart';
class CustomImageCard extends StatelessWidget {
  const CustomImageCard({super.key, required this.mekanResim});
  final String mekanResim;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(mekanResim),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
