import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_tasarim/features/AnaEkran/widgets/adres_pop_up_widgets.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  // AppBar içeriğini gösteren widget
  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    // Ekran yüksekliğini almak için MediaQuery kullanılır
    double ekranYuksekligi = MediaQuery.of(context).size.height;

    return AppBar(
      toolbarHeight: ekranYuksekligi / 10, // AppBar yüksekliğini ekranın 1/10'i kadar yapıyoruz
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Başlıkları sola hizalar
        children: <Widget>[
          // "Explore" başlığı
          Text(
            'Explore',
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          // "Aspen" başlığı (daha büyük font boyutu)
          Text(
            'Aspen',
            style: GoogleFonts.montserrat(
              fontSize: 48,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      actions: const <Widget>[
        // Adres seçimi için pop-up widget'ı
        AdresPopUpWidget(),
      ],
    );
  }
}
