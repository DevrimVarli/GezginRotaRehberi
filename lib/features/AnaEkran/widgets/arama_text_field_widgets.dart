import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_ce/hive.dart';

import 'package:yeni_tasarim/providers/all_providers.dart';

class AramaTextFieldWidget extends ConsumerWidget {
  const AramaTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Box<String>box = Hive.box<String>('aramaSonuclari');
    // Tema renk düzeni
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // Ekran yüksekliğini almak için MediaQuery kullanılır
    double e = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8), // Padding eklenir
      child: SizedBox(
        height: e * 0.06, // TextField'ın yüksekliğini ekranın %6'sı kadar yapıyoruz
        child: TextField(
          onChanged: (String aramaSonucu) {
            // Kullanıcı her arama yaptığında, arama sonucunu 'aramaSonucuStateProvider' ile güncelliyoruz
            ref.read(aramaSonucuStateProvider.notifier).state = aramaSonucu;
          },
          /*onSubmitted: (String value){
            if( box.values.toList().length==5){
              if(box.values.toList().contains(value)){
                box..delete(value)
                  ..put(value, value);

              }else{
              box..delete(box.values.toList()[0])
              ..put(value, value);}
            }
            if(box.values.toList().length<5){
              box.put(value, value);
            }
            if(box.values.toList().contains(value)){
              box..delete(value)
              ..put(value, value);
            }

          },*/
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search, // Arama simgesi
              size: 20,
              color: colorScheme.outlineVariant, // İkon rengi tema ile uyumlu
            ),
            labelStyle: TextStyle(
              fontSize: 24, // Etiket yazı boyutu
              color: colorScheme.primary, // Etiket rengi tema ana rengiyle uyumlu
              fontWeight: FontWeight.bold, // Etiket kalınlığı
            ),
            hintText: 'Find things to do', // Arama çubuğunda görünen ipucu
            hintStyle: GoogleFonts.roboto(
              fontSize: 18, // İpucu yazı boyutu
              color: colorScheme.outlineVariant, // İpucu yazı rengi tema ile uyumlu
              fontWeight: FontWeight.w500, // İpucu yazı kalınlığı
            ),
            filled: true, // Arka plan rengini dolu yapıyoruz
            fillColor: Colors.transparent.withValues(alpha: 0.02), // Zemin rengini şeffaf yapıyoruz
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18), // İç padding
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24), // Kenarları yuvarlıyoruz
              borderSide: const BorderSide(color: Colors.transparent, width: 2), // Etkinken kenar rengi
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24), // Kenarları yuvarlıyoruz
              borderSide: BorderSide(
                color: colorScheme.primary, // Odak rengi tema ile uyumlu
                width: 2, // Kenar çizgi kalınlığı
              ),
            ),
          ),
        ),
      ),
    );
  }
}
