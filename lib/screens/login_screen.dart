import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/features/sig_up_screen/custom_sign_up_form.dart';
import 'package:yeni_tasarim/features/sign_in_screen/widgets/custom_form.dart';
import 'package:yeni_tasarim/features/sign_in_screen/widgets/custom_log_in_button.dart';
import 'package:yeni_tasarim/features/sign_in_screen/widgets/custom_logo_and_welcome_text.dart';
import 'package:yeni_tasarim/features/sign_in_screen/widgets/custom_sign_in_google_button.dart';
import 'package:yeni_tasarim/features/sign_in_screen/widgets/custom_theme_change_button.dart';
import '../features/sig_up_screen/custom_create_button.dart';
import '../features/sig_up_screen/custom_sign_in_orientation.dart';
import '../features/sig_up_screen/custom_text_sign_up.dart';
import '../features/sign_in_screen/widgets/custom_sign_up_button.dart';
import '../providers/all_providers.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final ekranGenisligi = MediaQuery.sizeOf(context).width;
    final ekranYuksekligi = MediaQuery.sizeOf(context).height;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final kayitMi=ref.watch(kayitMiProvider);
    var formKey=GlobalKey<FormState>();


    return Scaffold(
      backgroundColor: colorScheme.surface, // tema zemin rengi
      body:kayitMi? Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             CustomTextSignUp(),
             CustomSignUpForm(formKey: formKey),
              CustomCreateButton(formKey: formKey),
             CustomSignInOrientation(),


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
            boxShadow: [
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
            children: [
              // Sayfa body’sinin üstüne ekle (Stack yerine Row da olur)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                  child: CustomThemeChangeButton(),
                ),
              ),
              CustomLogoAndWelcomeText(),
              // Username
              CustomForm(formKey: formKey),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
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
                "OR sign up using",
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ),

              // Google Button
              CustomSignInGoogleButton(),

              // Sign Up Row
              CustomSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}
