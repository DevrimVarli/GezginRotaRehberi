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
            size: 30,
          ),
          SizedBox(width: 8),
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
            elevation: 3, // Gölge efekti
            shadowColor: Colors.black.withOpacity(0.3), // Gölgenin saydamlığı
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Köşe yuvarlama
            ),
            color: Colors.white, // Menü arka plan rengi
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 30,
              color: Colors.blueAccent,
            ),
            itemBuilder: (BuildContext context) {
              return konumList.map((Konum konum) {
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

                      ],
                    ),
                  ),
                );
              }).toList();
            },
            onCanceled: () {
              print("Seçim iptal edildi");
            },
            onSelected: (Konum selectedKonum) {
              ref.read(secilemKonumStateProvider.notifier).state = selectedKonum;
            },
          ),
        ],
      ),
    );
  }
}
