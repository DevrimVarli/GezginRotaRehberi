import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:yeni_tasarim/features/adres_ekle_screen/widgets/custom_elevated_button.dart';
import 'package:yeni_tasarim/features/adres_ekle_screen/widgets/custom_form_adress.dart';
import 'package:yeni_tasarim/model/kullanici_konum_freezed.dart';

class AdresScreenDetay extends ConsumerStatefulWidget {
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

  bool get konumdanMiGeldi =>
      kullaniciKonum != null &&
          (adresAdi == null && ilAdi == null && ilceAdi == null);


  @override
  ConsumerState<AdresScreenDetay> createState() => _AdresScreenDetayState();
}

class _AdresScreenDetayState extends ConsumerState<AdresScreenDetay> {
  TextEditingController adresim = TextEditingController();
  TextEditingController ilim = TextEditingController();
  TextEditingController ilcem = TextEditingController();
  TextEditingController mahallem = TextEditingController();
  TextEditingController binam = TextEditingController();
  TextEditingController katm =TextEditingController();
  TextEditingController dairem = TextEditingController();
  TextEditingController adresTarifi = TextEditingController();
  TextEditingController adresBasligi = TextEditingController();
  TextEditingController ad = TextEditingController();
  TextEditingController soyad = TextEditingController();
  TextEditingController cepTelefonu = TextEditingController();
  TextEditingController sokak = TextEditingController();
  Box<KullaniciKonumFreezed> box = Hive.box<KullaniciKonumFreezed>('konumlar');
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void _setTextValues() {
    adresim.text =
    (widget.konumdanMiGeldi ? widget.kullaniciKonum?.disyplayName :widget.adresAdi)!;
    ilim.text = (widget.konumdanMiGeldi ? widget.kullaniciKonum?.sehirAdi : widget.ilAdi)!;
    ilcem.text = (widget.konumdanMiGeldi ? widget.kullaniciKonum?.ilceAdi : widget.ilceAdi)!;
    mahallem.text =
    (widget.konumdanMiGeldi ? widget.kullaniciKonum?.mahalleAdi : widget.mahalleAdi)!;
    sokak.text = (widget.konumdanMiGeldi ? widget.kullaniciKonum?.sokakAdi : widget.sokakAdi)!;
    binam.text = (widget.konumdanMiGeldi ? widget.kullaniciKonum?.binaNo : '')!;
    katm.text = (widget.konumdanMiGeldi ? widget.kullaniciKonum?.katNo : '')!;
    dairem.text = (widget.konumdanMiGeldi ? widget.kullaniciKonum?.daireNo : '')!;
    adresTarifi.text = (widget.konumdanMiGeldi ? widget.kullaniciKonum?.adresTarifi : '')!;
    adresBasligi.text =
    (widget.konumdanMiGeldi ? widget.kullaniciKonum?.adresBasligi : '')!;
    ad.text = (widget.konumdanMiGeldi ? widget.kullaniciKonum?.ad : '')!;
    soyad.text = (widget.konumdanMiGeldi ? widget.kullaniciKonum?.soyad : '')!;
    cepTelefonu.text = (widget.konumdanMiGeldi ? widget.kullaniciKonum?.cepTelefonu : '')!;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setTextValues();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adres Bilgilerini Düzenle')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
           CustomFormAdress(adresim: adresim, ilim: ilim, ilcem: ilcem, mahallem: mahallem, binam: binam, katm: katm, dairem: dairem,konumdanMiGeldi: widget.konumdanMiGeldi,sokak: sokak, adresTarifi: adresTarifi, adresBasligi: adresBasligi, ad: ad, soyad: soyad, cepTelefonu: cepTelefonu, formKey: formKey,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomElevatedButton(formKey: formKey,adresim:  adresim,ilim:  ilim,ilcem:  ilcem,mahallem:  mahallem, binam: binam,katm:  katm,dairem:  dairem,adresTarifi:  adresTarifi,adresBasligi:  adresBasligi,ad:  ad,soyad:  soyad,cepTelefonu:  cepTelefonu,sokak:  sokak,box:  box,konumdanMiGeldi:  widget.konumdanMiGeldi),
            ),
          ],
        ),
      ),
    );
}

}
