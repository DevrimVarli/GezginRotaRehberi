import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/Imkanlar.dart';
class FacilitiesWidgets extends StatelessWidget {
 List<Imkanlar>imkanList=[];
 double ekranGenisligi;
  FacilitiesWidgets({super.key, required this.ekranGenisligi, required this.imkanList});
//OTEL VEYA RESTORANTTA HANGİ HİZMETLER BULUNDUĞUNU GÖSTERİYOR
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Facilities",style: GoogleFonts.roboto(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),),
        SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imkanList.length,
            itemBuilder: (context, indeks) {
              Imkanlar imkan = imkanList[indeks];
              return Container(
                width: ekranGenisligi/4.6,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    imkan.icon,
                    SizedBox(height: 4),
                    Text(imkan.imkanAdi),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
