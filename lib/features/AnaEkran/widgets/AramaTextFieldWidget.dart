import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../providers/all_providers.dart';
class AramaTextFieldWidget extends ConsumerWidget {
  const AramaTextFieldWidget({super.key});
//ARAMA İÇİN TEXTFIELD
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal: 8 ),
      child: TextField(
        onChanged: (aramaSonucu){
          ref.read(aramaSonucuStateProvider.notifier).state=aramaSonucu;
        },
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
    );
  }
}
