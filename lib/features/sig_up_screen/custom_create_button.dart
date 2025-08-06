import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';

class CustomCreateButton extends ConsumerStatefulWidget {
  const CustomCreateButton({super.key, required this.formKey});

  final GlobalKey<FormState>
  formKey; // Formun global key'i, form durumunu yönetmek için kullanılır

  @override
  ConsumerState<CustomCreateButton> createState() => _CustomCreateButtonState();
}

class _CustomCreateButtonState extends ConsumerState<CustomCreateButton> {
  @override
  Widget build(BuildContext context) {
    // Form inputları için gerekli olan controller'ları Riverpod provider'dan alıyoruz
    TextEditingController emailController = ref.watch(emailControllerProvider);
    TextEditingController passwordController = ref.watch(
      passwordControllerProvider,
    );
    TextEditingController firstNameController = ref.watch(
      firstNameControllerProvider,
    );
    TextEditingController lastNameController = ref.watch(
      lastNameControllerProvider,
    );
    TextEditingController userNameController = ref.watch(
      userNameControllerProvider,
    );
    TextEditingController phoneNumberController = ref.watch(
      phoneNumberControllerProvider,
    );

    // Ekranın genişliğini alıyoruz
    double ekranGenisligi = MediaQuery.sizeOf(context).width;
    // Tema renk şemasını alıyoruz
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // Tema metin stilini alıyoruz
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        width:
            ekranGenisligi /
            2.25, // Butonun genişliğini ekran genişliğine göre ayarlıyoruz
        height: 53, // Butonun yüksekliği
        child: ElevatedButton(
          onPressed: () async {
            // Formun geçerli olup olmadığını kontrol ediyoruz
            bool kontrolSonucu = widget.formKey.currentState!.validate();

            if (kontrolSonucu) {
              // Form geçerliyse, kullanıcı kaydını gerçekleştiriyoruz
              await ref
                  .read(authProvider)
                  .kayitEkle(
                    context: context,
                    mail: emailController.text,
                    password: passwordController.text,
                    lastName: lastNameController.text,
                    firstName: firstNameController.text,
                    userName: userNameController.text,
                    phoneNumber: phoneNumberController.text,
                  );
            } else {
              // Formda hata varsa kullanıcıya uyarı mesajı gösteriyoruz
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Lütfen tüm alanları doğru şekilde doldurun!'),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                colorScheme.primary, // Butonun arka plan rengi tema ile uyumlu
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
              ), // Butonun yuvarlatılmış köşeleri
            ),
          ),
          child: Text(
            'create'.tr(), // Buton metni
            style: textTheme.labelLarge?.copyWith(
              color:
                  colorScheme.onPrimary, // Buton metninin rengi tema ile uyumlu
              fontWeight: FontWeight.bold, // Buton metninin kalınlığı
              fontSize: 18, // Buton metninin font büyüklüğü
            ),
          ),
        ),
      ),
    );
  }
}
