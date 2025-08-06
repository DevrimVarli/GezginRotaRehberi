import 'package:easy_localization/easy_localization.dart';
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
      key:
          formKey, // Formun geçerliliğini kontrol etmek için kullanılan form key
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly, // Dikeyde ortalanmış düzen
        children: <Widget>[
          // Başlık
          Text(
            'address_info'.tr(),
            style: textTheme.titleMedium?.copyWith(
              color:
                  colorScheme
                      .primary, // Başlık rengini tema ile uyumlu yapıyoruz
            ),
          ),
          // Adres alanı (Cadde, Sokak ve Diğer Bilgiler)
          CustomTextFormField(
            controller: adresim,
            textTheme: textTheme,
            colorScheme: colorScheme,
            label: 'address_placeholder'.tr(), // Etiket
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
                  label: 'province'.tr(),
                  validator: firstNameValidator,
                  readOnly: false,
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: ilcem,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                  label: 'district'.tr(),
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
                  label: 'neighborhood'.tr(),
                  validator: firstNameValidator,
                  readOnly: false,
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: sokak,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                  label: 'street'.tr(),
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
                  label: 'building_number'.tr(),
                  validator: firstNameValidator,
                  readOnly: false,
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: katm,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                  label: 'floor'.tr(),
                  validator: firstNameValidator,
                  readOnly: false,
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: dairem,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                  label: 'apartment_number'.tr(),
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
            label: 'address_recipe'.tr(),
            validator: firstNameValidator,
            readOnly: false,
          ),
          // Adres Başlığı (konumdan geldi ise readonly olacak)
          CustomTextFormField(
            controller: adresBasligi,
            textTheme: textTheme,
            colorScheme: colorScheme,
            label: 'address_title'.tr(),
            validator: firstNameValidator,
            readOnly: konumdanMiGeldi, // Eğer konumdan geldiyse readonly
          ),
          // İletişim Bilgileri başlığı
          Text(
            'contact_info'.tr(),
            style: textTheme.titleMedium?.copyWith(color: colorScheme.primary),
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
                  label: 'first_name'.tr(),
                  validator: firstNameValidator,
                  readOnly: false,
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: soyad,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                  label: 'last_name'.tr(),
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
            label: 'phone_number'.tr(),
            validator: phoneNumberValidator, // Telefon numarası doğrulaması
            readOnly: false,
          ),
        ],
      ),
    );
  }
}
