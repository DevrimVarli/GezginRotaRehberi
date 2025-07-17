import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/Restorantlar.dart';
import '../../../model/oteller.dart';
class MekanInfoWidgets extends StatelessWidget {
  Oteller? secilenOtel;
  Restorantlar? secilenRestorant;
  MekanInfoWidgets({super.key, this.secilenOtel, this.secilenRestorant});
//OTEL VEYA RESTORANT İÇERİĞİ GÖSTERİLİYOR
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0,bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                secilenOtel != null
                    ? secilenOtel!.otel_ad
                    : secilenRestorant!.restoran_ad,
                style: GoogleFonts.montserrat(
                  fontSize: secilenOtel!=null?secilenOtel!.otel_ad.length>20?16:24:secilenRestorant!.restoran_ad.length>20?16:24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Show map",
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow),
              SizedBox(width: 4),
              Text(
                secilenOtel != null
                    ? secilenOtel!.otel_yildiz.toString()
                    : secilenRestorant!.restoran_puan.toString(),
                style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(width: 4),
              Text(
                "(355 Reviews)",
                style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            secilenOtel != null
                ? "${secilenOtel!.otel_aciklama}"
                : "${secilenRestorant!.restoran_aciklama}",
            style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey.shade900),
          ),
          SizedBox(height: 4),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: Row(
              children: [
                Text(
                  "Read more",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
