import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_tasarim/model/Konum.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/adreslerim_screen.dart';

class AdresPopUpWidget extends ConsumerWidget {
  const AdresPopUpWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tema renk düzeni
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Riverpod kullanarak seçilen konumu izliyoruz
    Konum konum = ref.watch(secilemKonumStateProvider);

    return Align(
      // Popup widget'ının konumunu belirliyoruz (üst sola hizalı)
      alignment: Alignment.topLeft,
      child: GestureDetector(
        // Popup'a tıklandığında adresler ekranına yönlendiren işlem
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<Widget>(
              builder: (BuildContext context) => const AdresScreen(),
            ),
          );
        },
        child: Row(
          // İçeriklerin yatayda ortalanmasını sağlar
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Konum simgesi (harita simgesi)
            Icon(
              Icons.location_on,
              color: colorScheme.primary, // Tema renkleriyle uyumlu
              size: 20,
            ),
            const SizedBox(width: 1), // Arada küçük boşluk
            // Konum bilgisi (ilçe ve şehir adı)
            Text(
              '${konum.ilceAdi}, ${konum.sehirAdi}', // Konum bilgisi
              style: GoogleFonts.roboto(
                fontSize: 15, // Yazı boyutu
                color: colorScheme.primary, // Yazı rengi tema ile uyumlu
                fontWeight: FontWeight.w500, // Yazı kalınlığı
              ),
            ),
            const SizedBox(width: 2), // Arada küçük boşluk
            // Aşağı ok simgesi
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: colorScheme.primary, // Tema renkleriyle uyumlu
              size: 20,
            ),
            const SizedBox(width: 8), // Arada boşluk
          ],
        ),
      ),
    );
  }
}
