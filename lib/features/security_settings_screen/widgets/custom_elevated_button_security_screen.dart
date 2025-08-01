import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/services/auth_service.dart';

class CustomElevatedButtonSecurityScreen extends ConsumerWidget {
  const CustomElevatedButtonSecurityScreen({super.key, required this.mailController, required this.passwordController, required this.newPasswordController, required this.formKey});

  // TextEditingController'lar, kullanıcıdan alınacak verileri temsil eder
  final TextEditingController mailController;
  final TextEditingController passwordController;
  final TextEditingController newPasswordController;
  final GlobalKey<FormState> formKey; // Formun global key'ini alır, formun durumunu yönetmek için kullanılır

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ekranın genişliğini alıyoruz
    double ekranGenisligi = MediaQuery.of(context).size.width;

    // Tema renk düzenini ve metin stilini alıyoruz
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    // Şu anki kullanıcıyı alıyoruz
    User user = FirebaseAuth.instance.currentUser!;

    return SizedBox(
      width: ekranGenisligi / 1.5, // Butonun genişliği ekranın %66'sı kadar
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary, // Butonun arka plan rengi, tema ile uyumlu
        ),
        onPressed: () async {
          // Eğer form geçerliyse, işlemi yap
          if (formKey.currentState!.validate()) {
            AuthService auth = ref.read(authProvider); // AuthService'i provider'dan alıyoruz

            // Eğer mail adresi değiştirilmişse, mail değiştirme işlemi yapılır
            if (mailController.text != user.email) {
              await auth.changeEmail(
                newEmail: mailController.text, // Yeni e-posta adresi
                currentPassword: passwordController.text, // Şu anki şifre
                context: context,
              );
            }

            // Yeni şifre girildiyse, şifre değiştirme işlemi yapılır
            if (newPasswordController.text.isNotEmpty) {
              if (!context.mounted) return; // Eğer context kullanılabilir değilse, işlem yapılmaz
              await auth.changePassword(
                currentPassword: passwordController.text, // Şu anki şifre
                newPassword: newPasswordController.text, // Yeni şifre
                context: context,
              );
            }
          }
        },
        child: Text(
          'Kaydet', // Buton metni
          style: textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w400), // Buton metninin stilini belirler
        ),
      ),
    );
  }
}
