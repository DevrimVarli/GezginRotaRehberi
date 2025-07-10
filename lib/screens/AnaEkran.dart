import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yeni_tasarim/model/Konum.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';
import 'package:yeni_tasarim/model/oteller.dart';
import 'package:yeni_tasarim/repository/AdresRepo.dart';

import '../repository/RestorantRepo.dart';
import '../repository/otelRepo.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  List<Restorantlar>restorantlarList=[];
  List<Oteller>otelList=[];
  Konum secilenKonum=Konum(1, "Ankara", "Çankaya");
  List<Konum> konumList = [];
  List<String>basliklar=["Location", "Hotels","Food","Adventure","Location", "Hotels","Food","Adventure"];

  int selectedIndex= 0;
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AdresRepo().konumlar(konumList);
    RestorantRepo().restorantlar(restorantlarList);
    otelRepo().oteller(otelList);
  }
  Widget build(BuildContext context) {
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;
    double ekranGenisligi = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor:Colors.white10 ,
      appBar: AppBar(
        toolbarHeight: ekranYuksekligi/10,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Explore",style:GoogleFonts.montserrat(fontSize: 24,color: Colors.black,fontWeight: FontWeight.w500) ,),
            Text("Aspen",style:GoogleFonts.montserrat(fontSize: 48,color: Colors.black,fontWeight: FontWeight.w500) ,),
          ],
        ),
        actions: [
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: (){

              },
              child: Row(
                children: [
                  Icon(Icons.location_on,color: Colors.blueAccent,),
                  Text("${secilenKonum.ilce_adi},${secilenKonum.sehir_adi}",style:GoogleFonts.roboto(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500) ,),
                  PopupMenuButton(
                      child: Icon(Icons.keyboard_arrow_down_rounded,size: 25,),
                      itemBuilder: (context)=>[
                        PopupMenuItem(
                          value: 1,
                          child: Text("${konumList[0].ilce_adi},${konumList[0].sehir_adi}",style:GoogleFonts.roboto(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500) ,),),
                       PopupMenuItem(
                          value:2,
                          child: Text("${konumList[1].ilce_adi},${konumList[1].sehir_adi}",style:GoogleFonts.roboto(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500) ,),),
                       PopupMenuItem(
                          value: 3,
                          child: Text("${konumList[2].ilce_adi},${konumList[2].sehir_adi}",style:GoogleFonts.roboto(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500) ,),),
                       PopupMenuItem(
                          value: 4,
                          child: Text("${konumList[3].ilce_adi},${konumList[3].sehir_adi}",style:GoogleFonts.roboto(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500) ,),),

                      ],
                      onCanceled: (){
                        print("Seçim iptal edildi");
                      },
                      onSelected: (menuItemValue){
                        setState(() {
                          secilenKonum=konumList[menuItemValue-1];
                        });
                      }

                  ),

                ],
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal: 8 ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,size: 32,color:Colors.grey.shade400 ,),
                    //labelText: label,
                    labelStyle:TextStyle( fontSize: 22,color:  HexColor("#3674B5"),fontWeight: FontWeight.bold),
                    hintText: "Find things to do",
                    hintStyle: GoogleFonts.roboto(fontSize: 22,color: Colors.grey.shade400,fontWeight: FontWeight.w500),
                    filled: true,
                    fillColor: Color(0xFFE8F0FE),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.transparent, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: HexColor("#333446"), width: 2),
                    ),
                  ),
                ),
              ),
           SizedBox(
              height: 50,
              child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: basliklar.length,
              itemBuilder: (context, index) {
                final isSelected = selectedIndex == index;
                return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFFE8F0FE) : Colors.transparent,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Text(
                basliklar[index],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: isSelected ? Colors.blue : Colors.grey.shade600,
                ),
              ),
            ),
          ),
                );
              },
              ),
              ),
              Padding(
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
                              Container(
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
                                    child: Center(child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.favorite,color: Colors.red,)],
                                    )),
          
                              )),
                            ],
                          );
                        },
                      ),
                    ),
          
          
                  ],
                ),
              ),
              Padding(
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
                                child: Container(
                                  width: 280, // Genişliği sabitle
                                  margin: EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: AssetImage("assets/${otel.otel_resim}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          right:23 ,
                                          bottom:1,
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade800,
                                              borderRadius: BorderRadius.circular(16),
          
                                            ),
                                            child: Center(child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(otel.otel_yazi,style: GoogleFonts.roboto(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),),
                                              ],
                                            )),
          
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
              ),
          
          
          
          
          
            ],
          ),
        ),
      ),
    );
  }
}
