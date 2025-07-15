import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/oteller.dart';
import '../../../providers/all_providers.dart';
import '../../../screens/DetayEkrani.dart';
class OtellerListViewWidget extends ConsumerWidget {


//OTELLERİ GÖSTERİLİYOR
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otelList = ref.watch(otelFutureProvider);
    return otelList.when(data: (otelList){
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
                                    image: NetworkImage(otel.otel_resim),
                                    fit: BoxFit.cover,
                                  ),
                                ),

                              ),
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
    }, error: (error, stackTrace) => Center(child: Text(error.toString())),
    loading: ()=>Center(child: CircularProgressIndicator()));
  }


}
