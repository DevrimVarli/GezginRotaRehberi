import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/Restorantlar.dart';
import '../../../model/oteller.dart';
class PriceWidgets extends StatelessWidget {
  Oteller? secilenOtel;
  Restorantlar? secilenRestorant;
  double ekranGenisligi;
  PriceWidgets({super.key, this.secilenOtel, this.secilenRestorant, required this.ekranGenisligi});
//OTEL VEYA RESTORANT FIYATI GÖSTERİLİYOR
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: ekranGenisligi,
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Price",
                style: GoogleFonts.roboto(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                secilenOtel != null
                    ? "€${secilenOtel!.otelFiyat.toString()}"
                    : "€${secilenRestorant!.restoranFiyat}",
                style: GoogleFonts.roboto(fontSize: 32, color: Colors.greenAccent.shade700, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            width: ekranGenisligi/2,
            height: 60,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              child: Text(
                "Book Now ->",
                style: GoogleFonts.roboto(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
