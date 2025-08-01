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
  // Form alanları için controller'lar
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  // Form doğrulama anahtarı
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Giriş yapan kullanıcı
  User user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    // Mevcut kullanıcının e-posta adresini forma doldur
    mailController.text = user.email!;
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

      // Kullanıcı Firestore’da kayıtlı mı kontrol et
      body: ref.read(authProvider).kullaniciyiBul()
          ? FutureBuilder<Map<String, dynamic>?>(
        // Firestore’daki kullanıcı verilerini al
        future: ref.read(authProvider).getFirestoreUserData(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>?> snapshot,) {
          // Yükleniyor
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Hata veya veri yoksa
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
                child: Text('Kullanıcı verileri alınamadı.'),);
          }

          // Firestore’dan gelen kullanıcı verileri
          Map<String, dynamic> data = snapshot.data!;
          String firstName = data['firstName'].toString();
          String lastName = data['lastName'].toString();

          // Firestore verisi olan kullanıcı arayüzü
          return Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
            child: SingleChildScrollView(
              child: Column(
                spacing: 24,
                children: <Widget>[
                  // Profil fotoğrafı
                  CustomProfilPhoto(user: user, data: data),
                  // Ad Soyad
                  Text('$firstName $lastName',
                      style: textTheme.headlineSmall,),
                  // E-posta
                  Text(user.email ?? '', style: textTheme.bodyLarge),
                  // Şifre değiştirme formu
                  CustomForm(
                    formKey: formKey,
                    controllerMail: mailController,
                    controllerCurrentPassword: passwordController,
                    controllerNewPassword: newPasswordController,
                  ),
                  // Kaydet butonu
                  CustomElevatedButtonSecurityScreen(
                    mailController: mailController,
                    passwordController: passwordController,
                    newPasswordController: newPasswordController,
                    formKey: formKey,
                  ),
                ],
              ),
            ),
          );
        },
      )

      // Firestore verisi olmayan kullanıcı arayüzü
          : Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          spacing: 24,
          children: <Widget>[
            // Profil fotoğrafı
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(user.photoURL.toString()),
            ),
            // Ad Soyad
            Text(user.displayName.toString(),
                style: textTheme.headlineSmall,),
            // E-posta
            Text(user.email ?? '', style: textTheme.bodyLarge),
            // Şifre değiştirme formu
            CustomForm(
              formKey: formKey,
              controllerMail: mailController,
              controllerCurrentPassword: passwordController,
              controllerNewPassword: newPasswordController,
            ),
            // Kaydet butonu
            CustomElevatedButtonSecurityScreen(
              mailController: mailController,
              passwordController: passwordController,
              newPasswordController: newPasswordController,
              formKey: formKey,
            ),
          ],
        ),
      ),
    );
  }
}
