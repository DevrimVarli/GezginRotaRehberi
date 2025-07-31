
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:yeni_tasarim/model/kullanici_konum_freezed.dart';
import 'package:yeni_tasarim/screens/adreslerim_screen.dart';

class CustomElevatedButton extends StatelessWidget {


  const CustomElevatedButton({required this.formKey,required this.adresim,required this.ilim,required this.ilcem,
    required this.mahallem,required this.binam,required this.katm,required this.dairem,required this.adresTarifi,
    required  this.adresBasligi,required this.ad,required this.soyad,required this.cepTelefonu,required this.sokak,
    required this.box,required this.konumdanMiGeldi, super.key,});
  final GlobalKey<FormState> formKey;
  final TextEditingController adresim;
  final TextEditingController ilim;
  final TextEditingController ilcem;
  final TextEditingController mahallem;
  final TextEditingController binam;
  final TextEditingController katm;
  final TextEditingController dairem;
  final TextEditingController adresTarifi;
  final TextEditingController adresBasligi;
  final TextEditingController ad;
  final TextEditingController soyad;
  final TextEditingController cepTelefonu;
  final TextEditingController sokak;
  final Box<KullaniciKonumFreezed> box;
  final bool konumdanMiGeldi;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            KullaniciKonumFreezed yeniKonum = KullaniciKonumFreezed(
              disyplayName: adresim.text,
              binaNo: binam.text,
              katNo: katm.text,
              daireNo: dairem.text,
              adresTarifi: adresTarifi.text,
              adresBasligi: adresBasligi.text,
              ad: ad.text,
              soyad: soyad.text,
              cepTelefonu: cepTelefonu.text,
              sokakAdi: sokak.text,
              mahalleAdi: mahallem.text,
              ilceAdi: ilcem.text,
              sehirAdi: ilim.text,
            );

            await box.put(yeniKonum.adresBasligi, yeniKonum);
            if (!context.mounted) return;
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute<Widget>(
                builder: (BuildContext context) => const AdresScreen(),
              ),
            );
          }
        },
        child: Text(
          konumdanMiGeldi ? 'Kaydet' : 'Adresimi Kaydet',
          style: textTheme.titleMedium?.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
