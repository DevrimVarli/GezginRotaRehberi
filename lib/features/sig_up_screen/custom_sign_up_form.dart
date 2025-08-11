import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/services/validator.dart';
import 'package:yeni_tasarim/features/sig_up_screen/custom_text_form_field.dart';

class CustomSignUpForm extends ConsumerStatefulWidget {
  const CustomSignUpForm({super.key, required this.formKey});

  final GlobalKey<FormState> formKey; // Formun global key'i

  @override
  ConsumerState<CustomSignUpForm> createState() => _CustomSignUpFormState();
}

class _CustomSignUpFormState extends ConsumerState<CustomSignUpForm> {
  @override
  void dispose() {
    super.dispose();
    // Formda kullanılan tüm TextEditingController'ları temizler
    ref.read(emailControllerProvider).dispose();
    ref.read(passwordControllerProvider).dispose();
    ref.read(firstNameControllerProvider).dispose();
    ref.read(lastNameControllerProvider).dispose();
    ref.read(userNameControllerProvider).dispose();
    ref.read(phoneNumberControllerProvider).dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController'ları Riverpod'dan alıyoruz
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

    // Tema renk şemasını alıyoruz
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Form(
      key: widget.formKey, // Formu kontrol etmek için kullanılır
      child: Column(
        spacing: 20, // Form elemanları arasındaki boşluğu ayarlıyoruz
        children: <Widget>[
          // İlk ad alanı
          CustomTextFormField(
            tfc: firstNameController,
            validator: firstNameValidator,
            hintText: 'first_name'.tr(),
            obscureText: false,
            icon: Icon(Icons.person, color: colorScheme.onSurfaceVariant),
          ),
          // Soyad alanı
          CustomTextFormField(
            tfc: lastNameController,
            validator: lastNameValidator,
            hintText: 'last_name'.tr(),
            obscureText: false,
            icon: Icon(Icons.person, color: colorScheme.onSurfaceVariant),
          ),
          // Kullanıcı adı alanı
          CustomTextFormField(
            tfc: userNameController,
            validator: userNameValidator,
            hintText: 'user_name'.tr(),
            obscureText: false,
            icon: Icon(Icons.person, color: colorScheme.onSurfaceVariant),
          ),
          // Telefon numarası alanı
          CustomTextFormField(
            tfc: phoneNumberController,
            validator: phoneNumberValidator,
            hintText: 'phone_number'.tr(),
            obscureText: false,
            icon: Icon(Icons.phone, color: colorScheme.onSurfaceVariant),
          ),
          // E-posta alanı
          CustomTextFormField(
            tfc: emailController,
            validator: mailValidator,
            hintText: 'email'.tr(),
            obscureText: false,
            icon: Icon(Icons.mail, color: colorScheme.onSurfaceVariant),
          ),
          // Şifre alanı
          CustomTextFormField(
            tfc: passwordController,
            validator: passValidator,
            hintText: 'password'.tr(),
            obscureText: true,
            icon: Icon(Icons.lock, color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
