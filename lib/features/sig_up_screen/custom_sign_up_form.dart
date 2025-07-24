import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/services/validator.dart';
import 'package:yeni_tasarim/features/sig_up_screen/custom_text_form_field.dart';
class CustomSignUpForm extends ConsumerWidget {
  const CustomSignUpForm({super.key,required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextEditingController emailController = ref.watch(emailControllerProvider);
    TextEditingController passwordController = ref.watch(passwordControllerProvider);
    TextEditingController firstNameController = ref.watch(firstNameControllerProvider);
    TextEditingController lastNameController = ref.watch(lastNameControllerProvider);
    TextEditingController userNameController = ref.watch(userNameControllerProvider);
    TextEditingController phoneNumberController = ref.watch(phoneNumberControllerProvider);

    return  Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            CustomTextFormField(tfc: firstNameController, validator: firstNameValidator, hintText: 'First Name', obscureText: false, icon:Icon(Icons.person, color: colorScheme.onSurfaceVariant) ,),
            const SizedBox(height: 20,),
            CustomTextFormField(tfc: lastNameController, validator: lastNameValidator, hintText: 'Last Name', obscureText: false, icon:Icon(Icons.person, color: colorScheme.onSurfaceVariant) ,),
            const SizedBox(height: 20,),
            CustomTextFormField(tfc: userNameController, validator: userNameValidator, hintText: 'User Name', obscureText: false, icon:Icon(Icons.person, color: colorScheme.onSurfaceVariant) ,),
            const SizedBox(height: 20,),
            CustomTextFormField(tfc: phoneNumberController, validator: phoneNumberValidator, hintText: 'Phone Number', obscureText: false, icon:Icon(Icons.phone, color: colorScheme.onSurfaceVariant) ,),
            const SizedBox(height: 20,),
            CustomTextFormField(tfc: emailController, validator: mailValidator, hintText: 'Email', obscureText: false, icon:Icon(Icons.mail, color: colorScheme.onSurfaceVariant) ,),
            const SizedBox(height: 20,),
            CustomTextFormField(tfc: passwordController, validator: passValidator, hintText: 'Password', obscureText: true, icon:Icon(Icons.lock, color: colorScheme.onSurfaceVariant) ,),
          ],
        ),);
  }
}
