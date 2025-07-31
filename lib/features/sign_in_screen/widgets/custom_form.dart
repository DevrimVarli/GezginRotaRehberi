import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/services/validator.dart';
import 'package:yeni_tasarim/features/sig_up_screen/custom_text_form_field.dart';


class CustomForm extends ConsumerStatefulWidget {
  const CustomForm({super.key,required this.formKey});
  final GlobalKey<FormState> formKey;
  @override
  ConsumerState<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends ConsumerState<CustomForm> {
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text='';
    passwordController.text='';
  }
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Form(
      key: widget.formKey,
      child: Column(
        children: <Widget>[
          CustomTextFormField(tfc: emailController, validator: mailValidator, hintText: 'Email', obscureText: false, icon:Icon(Icons.mail, color: colorScheme.onSurfaceVariant) ,),
          const SizedBox(height: 20,),
          CustomTextFormField(tfc: passwordController, validator: passValidator, hintText: 'Password', obscureText: true, icon:Icon(Icons.lock, color: colorScheme.onSurfaceVariant) ,),

        ],),);
  }
}


