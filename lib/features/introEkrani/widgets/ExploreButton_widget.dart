import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../screens/BottomNavigationBar.dart';
class ExploreButtonWidget extends StatelessWidget {
  double ekranYuksekligi;
  double ekranGenisligi;
  ExploreButtonWidget({required this.ekranYuksekligi,required this.ekranGenisligi});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 50,
        left: 32,
        child: SizedBox(
          width: ekranGenisligi/1.21,
          height: ekranYuksekligi/20,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:HexColor("#176FF2"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  )
              ),
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Secim()));
              }, child: Text("Explore",style: GoogleFonts.montserrat(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),)),
        ));
  }
}
