import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/Konum.dart';
import '../../../providers/all_providers.dart';

class AdresPopUpWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final konum = ref.watch(secilemKonumStateProvider);
    final konumList = ref.watch(konumlarProvider);

    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            color: Colors.blueAccent,
            size: 28,
          ),
          SizedBox(width: 5),
          Text(
            "${konum.ilce_adi}, ${konum.sehir_adi}",
            style: GoogleFonts.roboto(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 8),
          PopupMenuButton<Konum>(
            elevation: 3,
            shadowColor: Colors.black.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.white,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 30,
              color: Colors.blueAccent,
            ),
            itemBuilder: (BuildContext context) {
              // Mevcut konum listesi
              final items = konumList.map((Konum konum) {
                return PopupMenuItem<Konum>(
                  value: konum,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.blueAccent,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "${konum.ilce_adi}, ${konum.sehir_adi}",
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              ref.read(konumlarProvider.notifier).state.remove(konum);
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.delete)
                        )
                      ],
                    ),
                  ),
                );
              }).toList();

              // Yeni adres ekle butonu
              items.add(
                PopupMenuItem<Konum>(
                  height: 48,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context); // Popup'ı kapat
                      _showAddAddressDialog(context, ref); // Yeni adres ekleme dialogunu göster
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.blueAccent,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Yeni Adres Ekle",
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );

              return items;
            },
            onCanceled: () {
              print("Seçim iptal edildi");
            },
            onSelected: (Konum selectedKonum) {
              ref.read(secilemKonumStateProvider.notifier).state = selectedKonum;
              if(ref.read(seeAllStateProvider)) {
                ref.read(seeAllStateProvider.notifier).state = !ref.read(seeAllStateProvider);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showAddAddressDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController cityController = TextEditingController();
    final TextEditingController districtController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.5),
          title: Text("Yeni Adres Ekle",style: GoogleFonts.roboto(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w500),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: TextStyle(color: Colors.white),
                controller: cityController,
                decoration: InputDecoration(
                  labelStyle: GoogleFonts.roboto(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500),
                  hintStyle: GoogleFonts.roboto(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500),
                  labelText: "Şehir",
                  hintText: "Şehir adını giriniz",
                ),
              ),
              SizedBox(height: 16),
              TextField(
               style: TextStyle(color: Colors.white),
                controller: districtController,
                decoration: InputDecoration(
                  labelStyle: GoogleFonts.roboto(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500),
                  hintStyle: GoogleFonts.roboto(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500),
                  labelText: "İlçe",
                  hintText: "İlçe adını giriniz",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("İptal",style: GoogleFonts.roboto(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500),),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                final newAddress = Konum(
                   cityController.text,
                   districtController.text,
                );
                ref.read(konumlarProvider.notifier).state.add(newAddress);
                Navigator.pop(context);
              },
              child: Text("Ekle",style: GoogleFonts.roboto(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),),
            ),
          ],
        );
      },
    );
  }
}