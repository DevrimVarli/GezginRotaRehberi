import 'package:flutter/material.dart';

class ArrowBackButtonWidgets extends StatelessWidget {
  const ArrowBackButtonWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Positioned(
      top: 20,
      left: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 40,
          width: 40,
          color: colorScheme.surface, // Arka plan temadan
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: colorScheme.onSurface, // İkon rengi temaya göre
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
