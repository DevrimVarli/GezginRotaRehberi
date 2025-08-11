import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';

class CustomLogInButton extends ConsumerStatefulWidget {
  const CustomLogInButton({super.key, required this.formKey});

  final GlobalKey<FormState>
  formKey; // Formun durumunu kontrol etmek için kullanılan global key

  @override
  ConsumerState<CustomLogInButton> createState() => _CustomLogInButtonState();
}

class _CustomLogInButtonState extends ConsumerState<CustomLogInButton> {
  @override
  void dispose() {
    super.dispose();
    // Formda kullanılan tüm TextEditingController'ları temizler
    ref.read(emailControllerProvider).dispose();
    ref.read(passwordControllerProvider).dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ekranın genişliğini ve yüksekliğini alıyoruz
    double ekranGenisligi = MediaQuery.sizeOf(context).width;
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;

    // Tema renk şeması ve metin stili
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    // Riverpod'dan controller'ları alıyoruz
    TextEditingController emailController = ref.watch(emailControllerProvider);
    TextEditingController passwordController = ref.watch(
      passwordControllerProvider,
    );

    return SizedBox(
      width:
          ekranGenisligi /
          2.25, // Butonun genişliğini ekranın genişliğine göre ayarlıyoruz
      height:
          ekranYuksekligi /
          17, // Butonun yüksekliğini ekranın yüksekliğine göre ayarlıyoruz
      child: ElevatedButton(
        onPressed: () async {
          // Formun doğrulama işlemini yapıyoruz
          bool kontrolSonucu = widget.formKey.currentState!.validate();
          if (kontrolSonucu) {
            // Eğer form geçerli ise, kullanıcıyı giriş yapmaya yönlendiriyoruz
            await ref
                .read(authProvider)
                .girisYap(
                  context: context,
                  email: emailController.text, // E-posta adresi
                  password: passwordController.text, // Şifre
                );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              colorScheme
                  .primary, // Tema renk şemasına uygun buton arka plan rengi
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              12,
            ), // Butonun yuvarlatılmış köşeleri
          ),
        ),
        child: Text(
          'login'.tr(), // Butonun metni
          style: textTheme.labelLarge?.copyWith(
            color: colorScheme.onPrimary, // Buton metninin rengi
            fontWeight: FontWeight.bold, // Kalın font
            fontSize: 18, // Metin boyutu
          ),
        ),
      ),
    );
  }
}
