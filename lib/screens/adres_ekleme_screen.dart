import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:yeni_tasarim/features/adres_ekle_screen/widgets/custom_elevated_button.dart';
import 'package:yeni_tasarim/features/adres_ekle_screen/widgets/custom_form_adress.dart';
import 'package:yeni_tasarim/model/kullanici_konum_freezed.dart';

/// Adres detay/düzenleme ekranı
/// Eğer konumdan gelindiyse adres bilgileri `KullaniciKonumFreezed` ile doldurulur.
/// Aksi durumda parametrelerden (`adresAdi`, `ilAdi` vs.) alınır.
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

  /// Eğer `kullaniciKonum` doluysa ve diğer adres parametreleri null ise
  /// bu ekran konumdan gelmiş kabul edilir
  bool get konumdanMiGeldi =>
      kullaniciKonum != null &&
      (adresAdi == null && ilAdi == null && ilceAdi == null);

  @override
  ConsumerState<AdresScreenDetay> createState() => _AdresScreenDetayState();
}

class _AdresScreenDetayState extends ConsumerState<AdresScreenDetay> {
  @override
  void dispose() {
    super.dispose();
    // TextEditingController'ları temizler
    adresim.dispose();
    ilim.dispose();
    ilcem.dispose();
    mahallem.dispose();
    binam.dispose();
    katm.dispose();
    dairem.dispose();
    adresTarifi.dispose();
    adresBasligi.dispose();
    ad.dispose();
    soyad.dispose();
    cepTelefonu.dispose();
    sokak.dispose();
  }

  // Form alanlarının controller'ları
  final TextEditingController adresim = TextEditingController();
  final TextEditingController ilim = TextEditingController();
  final TextEditingController ilcem = TextEditingController();
  final TextEditingController mahallem = TextEditingController();
  final TextEditingController binam = TextEditingController();
  final TextEditingController katm = TextEditingController();
  final TextEditingController dairem = TextEditingController();
  final TextEditingController adresTarifi = TextEditingController();
  final TextEditingController adresBasligi = TextEditingController();
  final TextEditingController ad = TextEditingController();
  final TextEditingController soyad = TextEditingController();
  final TextEditingController cepTelefonu = TextEditingController();
  final TextEditingController sokak = TextEditingController();

  // Hive box (adres kayıtlarının tutulduğu yer)
  final Box<KullaniciKonumFreezed> box = Hive.box<KullaniciKonumFreezed>(
    'konumlar',
  );

  // Form doğrulama anahtarı
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Controller’lara başlangıç değerlerini set eder
  void _setTextValues() {
    adresim.text =
        (widget.konumdanMiGeldi
            ? widget.kullaniciKonum?.disyplayName
            : widget.adresAdi) ??
        '';
    ilim.text =
        (widget.konumdanMiGeldi
            ? widget.kullaniciKonum?.sehirAdi
            : widget.ilAdi) ??
        '';
    ilcem.text =
        (widget.konumdanMiGeldi
            ? widget.kullaniciKonum?.ilceAdi
            : widget.ilceAdi) ??
        '';
    mahallem.text =
        (widget.konumdanMiGeldi
            ? widget.kullaniciKonum?.mahalleAdi
            : widget.mahalleAdi) ??
        '';
    sokak.text =
        (widget.konumdanMiGeldi
            ? widget.kullaniciKonum?.sokakAdi
            : widget.sokakAdi) ??
        '';
    binam.text =
        widget.konumdanMiGeldi ? widget.kullaniciKonum?.binaNo ?? '' : '';
    katm.text =
        widget.konumdanMiGeldi ? widget.kullaniciKonum?.katNo ?? '' : '';
    dairem.text =
        widget.konumdanMiGeldi ? widget.kullaniciKonum?.daireNo ?? '' : '';
    adresTarifi.text =
        widget.konumdanMiGeldi ? widget.kullaniciKonum?.adresTarifi ?? '' : '';
    adresBasligi.text =
        widget.konumdanMiGeldi ? widget.kullaniciKonum?.adresBasligi ?? '' : '';
    ad.text = widget.konumdanMiGeldi ? widget.kullaniciKonum?.ad ?? '' : '';
    soyad.text =
        widget.konumdanMiGeldi ? widget.kullaniciKonum?.soyad ?? '' : '';
    cepTelefonu.text =
        widget.konumdanMiGeldi ? widget.kullaniciKonum?.cepTelefonu ?? '' : '';
  }

  @override
  void initState() {
    super.initState();
    _setTextValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('edit_address_title'.tr())),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Adres formu
            CustomFormAdress(
              adresim: adresim,
              ilim: ilim,
              ilcem: ilcem,
              mahallem: mahallem,
              binam: binam,
              katm: katm,
              dairem: dairem,
              konumdanMiGeldi: widget.konumdanMiGeldi,
              sokak: sokak,
              adresTarifi: adresTarifi,
              adresBasligi: adresBasligi,
              ad: ad,
              soyad: soyad,
              cepTelefonu: cepTelefonu,
              formKey: formKey,
            ),

            // Kaydet butonu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomElevatedButton(
                formKey: formKey,
                adresim: adresim,
                ilim: ilim,
                ilcem: ilcem,
                mahallem: mahallem,
                binam: binam,
                katm: katm,
                dairem: dairem,
                adresTarifi: adresTarifi,
                adresBasligi: adresBasligi,
                ad: ad,
                soyad: soyad,
                cepTelefonu: cepTelefonu,
                sokak: sokak,
                box: box,
                konumdanMiGeldi: widget.konumdanMiGeldi,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
