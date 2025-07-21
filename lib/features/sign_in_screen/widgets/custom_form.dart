import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/all_providers.dart';
import '../../../services/validator.dart';
import '../../sig_up_screen/custom_text_form_field.dart';
class CustomForm extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  const CustomForm({super.key,required this.formKey});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);
    return Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(tfc: emailController, validator: mailValidator, hintText: "Email", obscureText: false, icon:Icon(Icons.mail, color: colorScheme.onSurfaceVariant) ,),
            SizedBox(height: 20,),
            CustomTextFormField(tfc: passwordController, validator: passValidator, hintText: "Password", obscureText: true, icon:Icon(Icons.lock, color: colorScheme.onSurfaceVariant) ,),

          ],));
  }
}