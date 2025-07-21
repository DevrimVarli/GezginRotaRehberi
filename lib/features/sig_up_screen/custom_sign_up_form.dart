import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/all_providers.dart';
import '../../services/validator.dart';
import 'custom_text_form_field.dart';
class CustomSignUpForm extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  const CustomSignUpForm({super.key,required this.formKey});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);
    final firstNameController = ref.watch(firstNameControllerProvider);
    final lastNameController = ref.watch(lastNameControllerProvider);
    final userNameController = ref.watch(userNameControllerProvider);

    return  Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(tfc: firstNameController, validator: firstNameValidator, hintText: "First Name", obscureText: false, icon:Icon(Icons.person, color: colorScheme.onSurfaceVariant) ,),
            SizedBox(height: 20,),
            CustomTextFormField(tfc: lastNameController, validator: lastNameValidator, hintText: "Last Name", obscureText: false, icon:Icon(Icons.person, color: colorScheme.onSurfaceVariant) ,),
            SizedBox(height: 20,),
            CustomTextFormField(tfc: userNameController, validator: userNameValidator, hintText: "User Name", obscureText: false, icon:Icon(Icons.person, color: colorScheme.onSurfaceVariant) ,),
            SizedBox(height: 20,),
            CustomTextFormField(tfc: emailController, validator: mailValidator, hintText: "Email", obscureText: false, icon:Icon(Icons.mail, color: colorScheme.onSurfaceVariant) ,),
            SizedBox(height: 20,),
            CustomTextFormField(tfc: passwordController, validator: passValidator, hintText: "Password", obscureText: true, icon:Icon(Icons.lock, color: colorScheme.onSurfaceVariant) ,),
          ],
        ));
  }
}
