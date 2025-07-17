import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomTextName extends StatelessWidget {
  String mekan_ad;
  CustomTextName({super.key,required this.mekan_ad});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 10,
        left: 10,
        child: Container(
          height: 40,
          color: Colors.black.withValues(alpha: 0.7),
          child: Row(
            children: [
              Text(mekan_ad,style: GoogleFonts.montserrat(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500),)
            ],
          ),
        )
    );
  }
}
