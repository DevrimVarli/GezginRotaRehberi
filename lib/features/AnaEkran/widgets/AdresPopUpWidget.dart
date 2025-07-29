import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/model/Konum.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/adreslerim_screen.dart';

class AdresPopUpWidget extends ConsumerWidget {
  const AdresPopUpWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Konum konum = ref.watch(secilemKonumStateProvider);
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute<Widget>(builder: (context)=>const AdresScreen()));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.location_on,
              color: colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 1),
            Text(
              '${konum.ilceAdi}, ${konum.sehirAdi}',
              style: GoogleFonts.roboto(
                fontSize: 15,
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 2),
            Icon(Icons.keyboard_arrow_down_outlined,color: colorScheme.primary,size: 20,),
            const SizedBox(width: 8,),
          ],
        ),
      ),
    );
  }
}
