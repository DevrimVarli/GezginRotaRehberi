import 'package:flutter/material.dart';
import 'package:yeni_tasarim/features/adres_ekle_screen/widgets/custom_text_form_field.dart';
import 'package:yeni_tasarim/services/validator.dart';

class CustomFormAdress extends StatelessWidget {

  const CustomFormAdress({
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
    required this.formKey,
    required this.konumdanMiGeldi,
    super.key,
  });

  // Kullanıcının adres, iletişim ve diğer bilgilerini alacak olan controller'lar
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

  // Form doğrulaması için kullanılan form key'i
  final GlobalKey<FormState> formKey;

  // Konumdan geldi mi gelmedi mi durumunu belirler
  final bool konumdanMiGeldi;

  @override
  Widget build(BuildContext context) {
    // Tema bilgilerini almak için kullanılan değişkenler
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Form(
      key: formKey, // Formun geçerliliğini kontrol etmek için kullanılan form key
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Dikeyde ortalanmış düzen
        children: <Widget>[
          // Başlık
          Text(
            'Adres Bilgileri',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.primary, // Başlık rengini tema ile uyumlu yapıyoruz
            ),
          ),
          // Adres alanı (Cadde, Sokak ve Diğer Bilgiler)
          CustomTextFormField(
            controller: adresim,
            textTheme: textTheme,
            colorScheme: colorScheme,
            label: 'Adres (Cadde,Sokak ve Diğer Bilgiler)', // Etiket
            validator: firstNameValidator, // Doğrulama fonksiyonu
            readOnly: false, // Kullanıcı adresi girebilir
          ),
          // İl ve İlçe için iki yan yana form alanı
          Row(
            spacing: 8, // Aralarındaki boşluk
            children: <Widget>[
              Expanded(
                child: CustomTextFormField(
                  controller: ilim,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                  label: 'İl',
                  validator: firstNameValidator,
                  readOnly: false,
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: ilcem,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                  label: 'İlçe',
                  validator: firstNameValidator,
                  readOnly: false,
                ),
              ),
            ],
          ),
          // Mahalle ve Sokak için iki yan yana form alanı
          Row(
            spacing: 8,
            children: <Widget>[
              Expanded(
                child: CustomTextFormField(
                  controller: mahallem,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                  label: 'Mahalle',
                  validator: firstNameValidator,
                  readOnly: false,
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: sokak,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                  label: 'Sokak',
                  validator: firstNameValidator,
                  readOnly: false,
                ),
              ),
            ],
          ),
          // Bina No, Kat ve Daire No için form alanları
          Row(
            spacing: 8,
            children: <Widget>[
              Expanded(
                child: CustomTextFormField(
                  controller: binam,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                  label: 'Bina No',
                  validator: firstNameValidator,
                  readOnly: false,
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: katm,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                  label: 'Kat',
                  validator: firstNameValidator,
                  readOnly: false,
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: dairem,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                  label: 'Daire No',
                  validator: firstNameValidator,
                  readOnly: false,
                ),
              ),
            ],
          ),
          // Adres Tarifi
          CustomTextFormField(
            controller: adresTarifi,
            textTheme: textTheme,
            colorScheme: colorScheme,
            label: 'Adres Tarifi',
            validator: firstNameValidator,
            readOnly: false,
          ),
          // Adres Başlığı (konumdan geldi ise readonly olacak)
          CustomTextFormField(
            controller: adresBasligi,
            textTheme: textTheme,
            colorScheme: colorScheme,
            label: 'Adres Başlığı',
            validator: firstNameValidator,
            readOnly: konumdanMiGeldi, // Eğer konumdan geldiyse readonly
          ),
          // İletişim Bilgileri başlığı
          Text(
            'İletişim Bilgileri',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
            ),
          ),
          // Ad ve Soyad için iki yan yana form alanı
          Row(
            spacing: 8,
            children: <Widget>[
              Expanded(
                child: CustomTextFormField(
                  controller: ad,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                  label: 'Ad',
                  validator: firstNameValidator,
                  readOnly: false,
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: soyad,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                  label: 'Soyad',
                  validator: firstNameValidator,
                  readOnly: false,
                ),
              ),
            ],
          ),
          // Cep telefonu alanı
          CustomTextFormField(
            controller: cepTelefonu,
            textTheme: textTheme,
            colorScheme: colorScheme,
            label: 'Cep Telefonu',
            validator: phoneNumberValidator, // Telefon numarası doğrulaması
            readOnly: false,
          ),
        ],
      ),
    );
  }
}
