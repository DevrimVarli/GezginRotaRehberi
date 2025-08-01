import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/features/security_settings_screen/widgets/custom_text_form_field.dart';
import 'package:yeni_tasarim/services/validator.dart';

class CustomForm extends ConsumerStatefulWidget {
  const CustomForm({super.key, required this.formKey, required this.controllerMail, required this.controllerCurrentPassword, required this.controllerNewPassword});

  // Form bileşenlerinin global key'leri ve kontrolcüleri
  final GlobalKey<FormState> formKey;
  final TextEditingController controllerMail;
  final TextEditingController controllerCurrentPassword;
  final TextEditingController controllerNewPassword;

  @override
  ConsumerState<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends ConsumerState<CustomForm> {
  @override
  Widget build(BuildContext context) {
    // Tema renk düzenini almak için kullanılan değişken
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Form(
      key: widget.formKey, // Formun global key'ini kullanıyoruz
      child: Column(
        spacing: 16, // Form elemanları arasına boşluk ekliyoruz
        children: <Widget>[
          // E-posta alanı
          CustomTextFormField(
            tfc: widget.controllerMail, // E-posta kontrolcüsü
            validator: mailValidator, // E-posta doğrulama fonksiyonu
            hintText: 'Email', // Placeholder metni
            obscureText: false, // E-posta alanı şifreli değil
            icon: const Icon(Icons.mail), // E-posta ikonu
            colorScheme: colorScheme, // Tema renk düzeni
          ),
          // Mevcut şifre alanı
          CustomTextFormField(
            tfc: widget.controllerCurrentPassword, // Mevcut şifre kontrolcüsü
            validator: passValidator, // Şifre doğrulama fonksiyonu
            hintText: 'Current Password', // Placeholder metni
            obscureText: true, // Şifreyi gizlemek için
            icon: const Icon(Icons.lock), // Şifre ikonu
            colorScheme: colorScheme, // Tema renk düzeni
          ),
          // Yeni şifre alanı
          CustomTextFormField(
            tfc: widget.controllerNewPassword, // Yeni şifre kontrolcüsü
            validator: passValidator2, // Yeni şifre doğrulama fonksiyonu
            hintText: 'New Password', // Placeholder metni
            obscureText: true, // Şifreyi gizlemek için
            icon: const Icon(Icons.lock_outline), // Yeni şifre ikonu
            colorScheme: colorScheme, // Tema renk düzeni
          ),
        ],
      ),
    );
  }
}
