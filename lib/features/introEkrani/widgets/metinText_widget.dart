import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class metinText extends StatelessWidget {
  const metinText({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 653,
        left: 32,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Plan your",style: GoogleFonts.montserrat(
                fontSize: 36,
                color: Colors.white
            ),),
            Text("Luxurious",style: GoogleFonts.montserrat(
              fontSize: 48,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),),
            Text("Vacation",style: GoogleFonts.montserrat(
                fontSize: 48,
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),),
          ],
        ));
  }
}
