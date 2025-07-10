import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/Restorantlar.dart';
import '../../../screens/DetayEkrani.dart';
class RestorantListViewWidget extends StatelessWidget {
  List<Restorantlar> restorantlarList;
  RestorantListViewWidget(this.restorantlarList);
//RESTORANLARİ GÖSTERİLİYOR
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.only(left: 8.0,right: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Popular",style: GoogleFonts.roboto(fontSize: 24,color: Colors.black,fontWeight: FontWeight.w500),),
                Text("See all",style: GoogleFonts.roboto(fontSize: 18,color: Colors.blueAccent,fontWeight: FontWeight.w500),),
              ],

            ),
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: restorantlarList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, indeks) {
                Restorantlar restorant = restorantlarList[indeks];
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetayEkrani(secilenRestorant: restorant,)));

                      },
                      child: Container(
                        width: 230, // Genişliği sabitle
                        margin: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage("assets/${restorant.restoran_resim}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        left:5,
                        bottom: 60,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(restorant.restoran_ad,style: GoogleFonts.roboto(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),),
                            ],
                          )),

                        )),

                    Positioned(
                        left:5,
                        bottom: 10,
                        child: Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star,color: Colors.yellow,size: 18,),
                              Text(restorant.restoran_puan,style: GoogleFonts.roboto(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),),
                            ],
                          )),

                        )),
                    Positioned(
                        right:30,
                        bottom: 10,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Icon(Icons.favorite,color: Colors.red,),

                        )),
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
