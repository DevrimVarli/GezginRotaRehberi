import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/Konum.dart';
class AdresPopUpWidget extends StatefulWidget {
  List<Konum>konumList;
  Konum secilenKonum;

//ADRES SEÇİMİ İÇİN POPUP
  AdresPopUpWidget(this.konumList, this.secilenKonum);

  @override
  State<AdresPopUpWidget> createState() => _AdresPopUpWidgetState();
}

class _AdresPopUpWidgetState extends State<AdresPopUpWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          Icon(Icons.location_on,color: Colors.blueAccent,),
          Text("${widget.secilenKonum.ilce_adi},${widget.secilenKonum.sehir_adi}",style:GoogleFonts.roboto(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500) ,),
          PopupMenuButton(
              child: Icon(Icons.keyboard_arrow_down_rounded,size: 25,),
              itemBuilder: (context)=>[
                PopupMenuItem(
                  value: 1,
                  child: Text("${widget.konumList[0].ilce_adi},${widget.konumList[0].sehir_adi}",style:GoogleFonts.roboto(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500) ,),),
                PopupMenuItem(
                  value:2,
                  child: Text("${widget.konumList[1].ilce_adi},${widget.konumList[1].sehir_adi}",style:GoogleFonts.roboto(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500) ,),),
                PopupMenuItem(
                  value: 3,
                  child: Text("${widget.konumList[2].ilce_adi},${widget.konumList[2].sehir_adi}",style:GoogleFonts.roboto(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500) ,),),
                PopupMenuItem(
                  value: 4,
                  child: Text("${widget.konumList[3].ilce_adi},${widget.konumList[3].sehir_adi}",style:GoogleFonts.roboto(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500) ,),),

              ],
              onCanceled: (){
                print("Seçim iptal edildi");
              },
              onSelected: (menuItemValue){
                setState(() {
                   widget.secilenKonum=widget.konumList[menuItemValue-1];
                });
              }

          ),

        ],
      ),
    );
  }
}
