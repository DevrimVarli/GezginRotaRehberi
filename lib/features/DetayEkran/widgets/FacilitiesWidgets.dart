
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/Imkanlar.dart';
import '../../../model/Restorantlar.dart';
import '../../../model/oteller.dart';
import '../../../providers/all_providers.dart';
class FacilitiesWidgets extends ConsumerWidget {
  Oteller? secilenOtel;
  Restorantlar? secilenRestorant;
 double ekranGenisligi;
  FacilitiesWidgets({super.key, required this.ekranGenisligi,this.secilenOtel,this.secilenRestorant});
  Icon iconuBuL(String gelenVeri){
    if(gelenVeri=="wifi"){
      return Icon(Icons.wifi);
    }
    else if(gelenVeri=="hot_tub"){
      return Icon(Icons.hot_tub);
    }
    else if(gelenVeri=="pool"){
      return Icon(Icons.pool);
    }
    else {
      return Icon(Icons.lunch_dining);
    }
  }
//OTEL VEYA RESTORANTTA HANGİ HİZMETLER BULUNDUĞUNU GÖSTERİYOR
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final restorantList=ref.watch(restoranFutureProvider);
    final otelList=ref.watch(otelFutureProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Facilities",style: GoogleFonts.roboto(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),),
        SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: secilenOtel != null?ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: secilenOtel!.imkanlar.length,
            itemBuilder: (context, indeks) {
              Imkanlar imkan = secilenOtel!.imkanlar[indeks];
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
                    iconuBuL(imkan.imkan_icon),
                    SizedBox(height: 4),
                    Text(imkan.imkanAdi),
                  ],
                ),
              );
            },
          ):ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: secilenRestorant!.imkanlar.length,
            itemBuilder: (context, indeks) {
              Imkanlar imkan = secilenRestorant!.imkanlar[indeks];
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
                    iconuBuL(imkan.imkan_icon),
                    SizedBox(height: 4),
                    Text(imkan.imkanAdi),
                  ],
                ),
              );
            },
          )
        ),
      ],
    );
  }
}
