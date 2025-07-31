import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/features/security_settings_screen/widgets/custom_text_form_field.dart';
import 'package:yeni_tasarim/services/validator.dart';

class CustomForm extends ConsumerStatefulWidget {
  const CustomForm({super.key,required this.formKey,required this.controllerMail,required this.controllerCurrentPassword,required this.controllerNewPassword});
   final GlobalKey<FormState> formKey;
   final TextEditingController controllerMail ;
   final TextEditingController controllerCurrentPassword ;
   final TextEditingController controllerNewPassword ;

  @override
  ConsumerState<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends ConsumerState<CustomForm> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Form(
      key: widget.formKey,
      child: Column(
        spacing: 16,
        children: <Widget>[
          CustomTextFormField(
            tfc: widget.controllerMail,
            validator: mailValidator,
            hintText: 'Email',
            obscureText: false,
            icon: const Icon(Icons.mail),
            colorScheme: colorScheme,
          ),
          CustomTextFormField(
            tfc: widget.controllerCurrentPassword,
            validator: passValidator,
            hintText: 'Current Password',
            obscureText: true,
            icon: const Icon(Icons.lock),
            colorScheme: colorScheme,
          ),
          CustomTextFormField(
            tfc: widget.controllerNewPassword,
            validator: passValidator2,
            hintText: 'New Password',
            obscureText: true,
            icon: const Icon(Icons.lock_outline),
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }
}
