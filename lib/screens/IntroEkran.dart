import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yeni_tasarim/screens/BottomNavigationBar.dart';
import 'package:yeni_tasarim/screens/AnaEkran.dart';

class IntroEkran extends StatefulWidget {
  const IntroEkran({super.key});

  @override
  State<IntroEkran> createState() => _IntroEkranState();
}

class _IntroEkranState extends State<IntroEkran> {
  @override
  Widget build(BuildContext context) {
    double ekranYuksekligi = MediaQuery.of(context).size.height;
    double ekranGenisligi = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height:ekranYuksekligi ,
            width: ekranGenisligi,
            child: Image(image: AssetImage("assets/anaEkran.png"),fit: BoxFit.fill),
          ),
          Positioned(
              top: 93,
              left: 53,
              child: Text("Aspen",style: TextStyle(
                fontFamily: "Hiatus",
                color: Colors.white,
                fontSize: 150,
              ),)),
          Positioned(
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
              )),
          Positioned(
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
              )),


        ],
         
      ),

    );
  }
}
