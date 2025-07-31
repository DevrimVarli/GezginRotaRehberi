import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/features/security_settings_screen/widgets/custom_elevated_button_security_screen.dart';
import 'package:yeni_tasarim/features/security_settings_screen/widgets/custom_profil_photo.dart';
import 'package:yeni_tasarim/features/security_settings_screen//widgets/custom_form.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
class SecuritySettings extends ConsumerStatefulWidget {
  const SecuritySettings({super.key});

  @override
  ConsumerState<SecuritySettings> createState() => _SecuritySettingsState();
}

class _SecuritySettingsState extends ConsumerState<SecuritySettings> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User user=FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    mailController.text=user.email!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text('Güvenlik Ayarları', style: textTheme.headlineSmall),
          centerTitle: true,
        ),
        body:  ref.read(authProvider).kullaniciyiBul()?FutureBuilder<Map<String, dynamic>?>(
      future: ref.read(authProvider).getFirestoreUserData(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text('Kullanıcı verileri alınamadı.'));
        }

        Map<String, dynamic> data = snapshot.data!;
        String firstName = data['firstName'].toString();
        String lastName = data['lastName'].toString();

        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
            child: SingleChildScrollView(
              child: Column(
                spacing: 24,
                children: <Widget>[
                  CustomProfilPhoto(user: user, data: data),
                  Text('$firstName $lastName', style: textTheme.headlineSmall),
                  Text(user.email ?? '', style: textTheme.bodyLarge),
                  // Form alanları
                  CustomForm(formKey: formKey, controllerMail: mailController, controllerCurrentPassword: passwordController, controllerNewPassword: newPasswordController,),
                  CustomElevatedButtonSecurityScreen(mailController: mailController, passwordController: passwordController, newPasswordController: newPasswordController, formKey: formKey),
                ],
              ),
            ),
          );
      },
    ):
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          spacing: 24,
          children: <Widget>[
            // Profil fotoğrafı ve isimler
            CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(user.photoURL.toString()),
            ),
            Text(user.displayName.toString(), style: textTheme.headlineSmall),
            Text(user.email ?? '', style: textTheme.bodyLarge),
            // Form alanları
            CustomForm(formKey: formKey,controllerMail: mailController, controllerCurrentPassword: passwordController, controllerNewPassword: newPasswordController,),
            CustomElevatedButtonSecurityScreen(mailController: mailController, passwordController: passwordController, newPasswordController: newPasswordController, formKey: formKey),
          ],
        ),
      ),

    );
}


}
