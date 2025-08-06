import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:yeni_tasarim/model/kullanici_konum_freezed.dart';
import 'package:yeni_tasarim/screens/adreslerim_screen.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.formKey,
    required this.adresim,
    required this.ilim,
    required this.ilcem,
    required this.mahallem,
    required this.binam,
    required this.katm,
    required this.dairem,
    required this.adresTarifi,
    required this.adresBasligi,
    required this.ad,
    required this.soyad,
    required this.cepTelefonu,
    required this.sokak,
    required this.box,
    required this.konumdanMiGeldi,
    super.key,
  });

  // Formu doğrulamak ve verileri almak için kullanılan parametreler
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

  // Hive box nesnesi ve verilerin geldiği konum durumu
  final Box<KullaniciKonumFreezed> box;
  final bool konumdanMiGeldi;

  @override
  Widget build(BuildContext context) {
    // Tema renklerini almak için kullanılan değişkenler
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              colorScheme
                  .primary, // Butonun arka plan rengini tema renklerinden alır
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8,
            ), // Butonun köşe yuvarlama oranı
          ),
        ),
        onPressed: () async {
          // Form doğrulaması yapılır. Eğer geçerli ise işlemlere geçilir.
          if (formKey.currentState!.validate()) {
            // Kullanıcının girdiği verilerle yeni bir KullaniciKonumFreezed nesnesi oluşturulur
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

            // Yeni kullanıcı bilgileri Hive veritabanına kaydedilir.
            await box.put(yeniKonum.adresBasligi, yeniKonum);

            // Eğer context hâlâ aktifse, sayfa yönlendirmesi yapılır.
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
          // Butonun etiketi, "Kaydet" veya "Adresimi Kaydet" olarak değişir
          konumdanMiGeldi ? 'create'.tr() : 'save_address'.tr(),
          style: textTheme.titleMedium?.copyWith(
            color: Colors.white, // Buton üzerindeki yazının rengi
          ),
        ),
      ),
    );
  }
}
