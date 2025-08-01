import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/features/sig_up_screen/custom_text_form_field.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/services/validator.dart';

class CustomForm extends ConsumerStatefulWidget {
  const CustomForm({super.key, required this.formKey});

  final GlobalKey<FormState> formKey; // Formun global key'i, form durumunu kontrol etmek için kullanılır

  @override
  ConsumerState<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends ConsumerState<CustomForm> {
  @override
  Widget build(BuildContext context) {
    // Riverpod ile form elemanlarını kontrol etmek için gerekli olan controller'ları alıyoruz
    TextEditingController emailController = ref.watch(emailControllerProvider);
    TextEditingController passwordController = ref.watch(passwordControllerProvider);

    // Tema renk şeması
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Form(
      key: widget.formKey, // Formun kontrolünü sağlayacak key
      child: Column(
        children: <Widget>[
          // E-posta için CustomTextFormField widget'ı
          CustomTextFormField(
            tfc: emailController, // TextEditingController
            validator: mailValidator, // E-posta doğrulama fonksiyonu
            hintText: 'Email', // Giriş alanı için hint (yer tutucu) metni
            obscureText: false, // E-posta alanında metin gizlenmez
            icon: Icon(Icons.mail, color: colorScheme.onSurfaceVariant), // E-posta ikonu
          ),
          const SizedBox(height: 20), // E-posta ve şifre arasına boşluk ekliyoruz
          // Şifre için CustomTextFormField widget'ı
          CustomTextFormField(
            tfc: passwordController, // TextEditingController
            validator: passValidator, // Şifre doğrulama fonksiyonu
            hintText: 'Password', // Giriş alanı için hint (yer tutucu) metni
            obscureText: true, // Şifre alanı gizli (obscured) olacak
            icon: Icon(Icons.lock, color: colorScheme.onSurfaceVariant), // Şifre ikonu
          ),
        ],
      ),
    );
  }
}
