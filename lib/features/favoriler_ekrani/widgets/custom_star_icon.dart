import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomStarIcon extends StatelessWidget {
  String mekan_puan;
  CustomStarIcon({super.key,required this.mekan_puan});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 10,
        right: 10,
        child: Container(
          color: Colors.black.withValues(alpha: 0.7),
          child: Row(
            children: [
              Icon(Icons.star,color: Colors.yellow,),
              Text(mekan_puan,style: GoogleFonts.montserrat(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500),)
            ],
          ),
        )
    );
  }
}
