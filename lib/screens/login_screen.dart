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
    double ekranGenisligi = MediaQuery.sizeOf(context).width;
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    bool kayitMi=ref.watch(kayitMiProvider);
    GlobalKey<FormState> formKey=GlobalKey<FormState>();


    return Scaffold(
      backgroundColor: colorScheme.surface, // tema zemin rengi
      body:kayitMi? Center(
        child: Padding(
          padding: const EdgeInsets.all(18),
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
      ): Center(
        child: Container(
          height: ekranYuksekligi,
          width: ekranGenisligi,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.05),
                blurRadius: 20,
                spreadRadius: 5,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Sayfa body’sinin üstüne ekle (Stack yerine Row da olur)
              const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 16, right: 16),
                  child: CustomThemeChangeButton(),
                ),
              ),
              const CustomLogoAndWelcomeText(),
              // Username
              CustomForm(formKey: formKey),

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
              CustomLogInButton(formKey: formKey),

              Text(
                'OR sign up using',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ),

              // Google Button
              const CustomSignInGoogleButton(),

              // Sign Up Row
              const CustomSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}
