import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:yeni_tasarim/model/kullanici_konum.dart';
import 'package:yeni_tasarim/model/kullanici_konum_freezed.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/adreslerim_screen.dart';
import 'package:yeni_tasarim/services/validator.dart';
class AdresScreenDetay extends ConsumerWidget {

  const AdresScreenDetay({
    super.key,
    this.adresAdi,
    this.ilAdi,
    this.ilceAdi,
    this.mahalleAdi,
    this.sokakAdi,
    this.kullaniciKonum,
  });
  final String? adresAdi;
  final String? ilAdi;
  final String? ilceAdi;
  final String? mahalleAdi;
  final String? sokakAdi;
  final KullaniciKonumFreezed? kullaniciKonum;

  bool get _konumdanMiGeldi =>
      kullaniciKonum != null &&
          (adresAdi == null && ilAdi == null && ilceAdi == null);



  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final box=Hive.box<KullaniciKonumFreezed>('konumlar');
    TextEditingController adresim=ref.watch(adresTfc);
    final ilim=ref.watch(ilTfc);
    final ilcem=ref.watch(ilceTfc);
    final mahallem=ref.watch(mahalleTfc);
    final binam=ref.watch(binaTfc);
    final katm=ref.watch(katTfc);
    final dairem=ref.watch(daireTfc);
    final adresTarifi=ref.watch(adresTarifiTfc);
    final adresBasligi=ref.watch(adresBasligiTfc);
    final ad=ref.watch(adTfc);
    final soyad=ref.watch(soyadTfc);
    final cepTelefonu=ref.watch(cepTelefonuTfc);
    final sokak=ref.watch(sokakTfc);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    GlobalKey<FormState> formKey=GlobalKey<FormState>();
    adresim.text =(_konumdanMiGeldi ? kullaniciKonum?.disyplayName : adresAdi)!;
    ilim.text=(_konumdanMiGeldi ? kullaniciKonum?.sehirAdi : ilAdi)!;
    ilcem.text=(_konumdanMiGeldi ? kullaniciKonum?.ilceAdi : ilceAdi)!;
    mahallem.text=(_konumdanMiGeldi ? kullaniciKonum?.mahalleAdi : mahalleAdi)!;;
    sokak.text=(_konumdanMiGeldi ? kullaniciKonum?.sokakAdi : sokakAdi)!;
    binam.text=(_konumdanMiGeldi ? kullaniciKonum?.binaNo : '')!;
    katm.text=(_konumdanMiGeldi ? kullaniciKonum?.katNo :'')!;
    dairem.text=(_konumdanMiGeldi ? kullaniciKonum?.daireNo : '')!;
    adresTarifi.text=(_konumdanMiGeldi ? kullaniciKonum?.adresTarifi : '')!;
    adresBasligi.text=(_konumdanMiGeldi ? kullaniciKonum?.adresBasligi :'')!;
    ad.text=(_konumdanMiGeldi ? kullaniciKonum?.ad : '')!;
    soyad.text=(_konumdanMiGeldi ? kullaniciKonum?.soyad : '')!;
    cepTelefonu.text=(_konumdanMiGeldi ? kullaniciKonum?.cepTelefonu : '')!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adres Bilgilerini Düzenle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Adres Bilgileri',style: textTheme.titleMedium?.copyWith(color: colorScheme.primary)),
                      customTextField(adresim, textTheme, colorScheme,'Adres (Cadde,Sokak ve Diğer Bilgiler)',firstNameValidator, false),
                      Row(
                        children: <Widget>[
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: customTextField(ilim, textTheme, colorScheme,'İl',firstNameValidator, false),),
                          const Spacer(),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: customTextField(ilcem, textTheme, colorScheme,'İlçe',firstNameValidator, false),),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: customTextField(mahallem, textTheme, colorScheme,'Mahalle',firstNameValidator, false),),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: customTextField(sokak, textTheme, colorScheme,'Sokak',firstNameValidator, false),),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: customTextField(binam, textTheme, colorScheme,'Bina No',firstNameValidator, false),),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: customTextField(katm, textTheme, colorScheme,'Kat',firstNameValidator, false),),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: customTextField(dairem, textTheme, colorScheme,'Daire No',firstNameValidator, false),),
                        ],
                      ),
                      customTextField(adresTarifi, textTheme, colorScheme,'Adres Tarifi',firstNameValidator, false),
                      customTextField(adresBasligi, textTheme, colorScheme,'Adres Başlığı',firstNameValidator,_konumdanMiGeldi? true: false),
                      Text('İletişim Bilgileri',style: textTheme.titleMedium?.copyWith(color: colorScheme.primary),),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: customTextField(ad, textTheme, colorScheme,'Adınız',firstNameValidator, false),),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: customTextField(soyad, textTheme, colorScheme,'Soyadınız',firstNameValidator, false),),
                        ],
                      ),
                      customTextField(cepTelefonu, textTheme, colorScheme,'Cep Telefonu',phoneNumberValidator, false),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                            onPressed: ()async{
                            if(formKey.currentState!.validate()){
                              final yeniKonum = KullaniciKonumFreezed(
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
                              await Navigator.pushReplacement(context,MaterialPageRoute<Widget>(builder: (context)=>const AdresScreen()));
                            }

                            },
                            child:  Text(_konumdanMiGeldi ? 'Kaydet' : 'Adresimi Kaydet',style:textTheme.titleMedium?.copyWith(color: Colors.white),),),),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
  Widget customTextField(TextEditingController controller,TextTheme textTheme,ColorScheme colorScheme,String label,String? Function(String?)? validator,bool readOnly){
  return TextFormField(
    readOnly: readOnly,
    validator: validator,
    controller:controller ,
    style: textTheme.titleMedium,
    decoration: InputDecoration(
      labelText:label,
      labelStyle:textTheme.titleMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.6)),
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      enabledBorder:  OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: colorScheme.onSurface.withValues(alpha: 0.6), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:  const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
    ),
  );
}
}

