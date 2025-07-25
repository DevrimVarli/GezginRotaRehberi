import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/features/sig_up_screen/custom_sign_up_form.dart';
import 'package:yeni_tasarim/features/sign_in_screen/widgets/custom_form.dart';
import 'package:yeni_tasarim/features/sign_in_screen/widgets/custom_log_in_button.dart';
import 'package:yeni_tasarim/features/sign_in_screen/widgets/custom_logo_and_welcome_text.dart';
import 'package:yeni_tasarim/features/sign_in_screen/widgets/custom_sign_in_google_button.dart';
import 'package:yeni_tasarim/features/sign_in_screen/widgets/custom_theme_change_button.dart';
import 'package:yeni_tasarim/features/sig_up_screen/custom_create_button.dart';
import 'package:yeni_tasarim/features/sig_up_screen/custom_sign_in_orientation.dart';
import 'package:yeni_tasarim/features/sig_up_screen/custom_text_sign_up.dart';
import 'package:yeni_tasarim/features/sign_in_screen/widgets/custom_sign_up_button.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    bool kayitMi=ref.watch(kayitMiProvider);
    GlobalKey<FormState> formKey=GlobalKey<FormState>();


    return Scaffold(
      backgroundColor: colorScheme.surface, // tema zemin rengi
      body:kayitMi? Padding(
        padding: const EdgeInsets.symmetric(vertical:12,horizontal: 12),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
               const CustomTextSignUp(),
               CustomSignUpForm(formKey: formKey),
                CustomCreateButton(formKey: formKey),
               const CustomSignInOrientation(),


              ],
            ),
          ),
        ),
      ): Padding(
        padding: const EdgeInsets.symmetric(vertical:12,horizontal: 12),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Sayfa body’sinin üstüne ekle (Stack yerine Row da olur)
                const Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, right: 5),
                    child: CustomThemeChangeButton(),
                  ),
                ),
                const CustomLogoAndWelcomeText(),
                // Username
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CustomForm(formKey: formKey),
                ),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ),

                // Login Button
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CustomLogInButton(formKey: formKey),
                ),

                Text(
                  'OR sign up using',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),

                // Google Button
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomSignInGoogleButton(),
                ),

                // Sign Up Row
                const CustomSignUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
