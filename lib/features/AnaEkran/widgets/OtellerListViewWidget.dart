import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/oteller.dart';
import '../../../screens/DetayEkrani.dart';
class OtellerListViewWidget extends StatelessWidget {
  List<Oteller>otelList;
  OtellerListViewWidget(this.otelList);

//OTELLERİ GÖSTERİLİYOR
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text("Recommended",style: GoogleFonts.roboto(fontSize: 24,color: Colors.black,fontWeight: FontWeight.w500),)),
          SizedBox(
            height: 150,
            child: ListView.builder(
              itemCount: otelList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, indeks) {
                Oteller otel = otelList[indeks];
                return Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetayEkrani(secilenOtel: otel,)));
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 280, // Genişliği sabitle
                              margin: EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: AssetImage("assets/${otel.otel_resim}"),
                                  fit: BoxFit.cover,
                                ),
                              ),

                            ),
                            Positioned(
                                right:23 ,
                                bottom:1,
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade800,
                                    borderRadius: BorderRadius.circular(16),

                                  ),
                                  child: Center(child: Text(otel.otel_yazi,style: GoogleFonts.roboto(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),)),

                                ))
                          ],
                        ),


                      ),
                    ),
                    Text(otel.otel_ad,style: GoogleFonts.roboto(fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold),),

                  ],
                );
              },
            ),
          ),



        ],
      ),
    );
  }
}
