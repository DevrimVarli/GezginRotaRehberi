import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/features/sig_up_screen/custom_create_button.dart';
import 'package:yeni_tasarim/features/sig_up_screen/custom_sign_in_orientation.dart';
import 'package:yeni_tasarim/features/sig_up_screen/custom_sign_up_form.dart';
import 'package:yeni_tasarim/features/sig_up_screen/custom_text_sign_up.dart';
import 'package:yeni_tasarim/features/sign_in_screen/widgets/custom_log_in_button.dart';
import 'package:yeni_tasarim/features/sign_in_screen/widgets/custom_logo_and_welcome_text.dart';
import 'package:yeni_tasarim/features/sign_in_screen/widgets/custom_sign_in_google_button.dart';
import 'package:yeni_tasarim/features/sign_in_screen/widgets/custom_sign_up_button.dart';
import 'package:yeni_tasarim/features/sign_in_screen/widgets/custom_theme_change_button.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/features/sign_in_screen/widgets/custom_form.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tema renkleri
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // Yazı stili
    TextTheme textTheme = Theme.of(context).textTheme;
    // Kullanıcı kayıt ekranında mı? giriş ekranında mı?
    bool kayitMi = ref.watch(kayitMiProvider);
    // Form doğrulama anahtarı
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      // Tema zemin rengi
      backgroundColor: colorScheme.surface,
      // Eğer kayıt ekranı ise
      body:
          kayitMi
              ? Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // "Sign Up" başlığı
                        const CustomTextSignUp(),
                        // Kayıt formu
                        CustomSignUpForm(formKey: formKey),
                        // Kayıt ol butonu
                        CustomCreateButton(formKey: formKey),
                        // "Already have an account?" yönlendirmesi
                        const CustomSignInOrientation(),
                      ],
                    ),
                  ),
                ),
              )
              // Eğer giriş ekranı ise
              : Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Tema değiştirme butonu (sağ üst)
                        Row(
                          children: <Widget>[
                            const Spacer(),
                            if (context.locale.languageCode == 'tr')
                              TextButton.icon(
                                onPressed: () {
                                  context.setLocale(const Locale('en'));
                                },
                                label: const Text(
                                  'TR',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                icon: const Icon(Icons.language),
                              )
                            else
                              TextButton.icon(
                                onPressed: () {
                                  context.setLocale(const Locale('tr'));
                                },
                                label: const Text(
                                  'EN',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                icon: const Icon(Icons.language),
                              ),
                            const Padding(
                              padding: EdgeInsets.only(top: 5, right: 5),
                              child: CustomThemeChangeButton(),
                            ),
                          ],
                        ),
                        // Logo + Hoş geldiniz yazısı
                        const CustomLogoAndWelcomeText(),
                        // Kullanıcı giriş formu
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: CustomForm(formKey: formKey),
                        ),
                        // Şifremi unuttum butonu
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'forgot_password'.tr(),
                              style: textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        // Giriş yap butonu
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: CustomLogInButton(formKey: formKey),
                        ),
                        // Alternatif giriş açıklaması
                        Text(
                          'sign_up_using'.tr(),
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.8),
                          ),
                        ),
                        // Google ile giriş butonu
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: CustomSignInGoogleButton(),
                        ),
                        // Kayıt ol yönlendirmesi
                        const CustomSignUpButton(),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }
}
