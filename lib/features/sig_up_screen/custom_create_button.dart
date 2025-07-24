import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yeni_tasarim/providers/all_providers.dart';
class CustomCreateButton extends ConsumerWidget {
  const CustomCreateButton({super.key,required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    double ekranGenisligi = MediaQuery.sizeOf(context).width;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    TextEditingController emailController = ref.watch(emailControllerProvider);
    TextEditingController passwordController = ref.watch(passwordControllerProvider);
    TextEditingController firstNameController = ref.watch(firstNameControllerProvider);
    TextEditingController lastNameController = ref.watch(lastNameControllerProvider);
    TextEditingController userNameController = ref.watch(userNameControllerProvider);
    TextEditingController phoneNumberController = ref.watch(phoneNumberControllerProvider);
    return SizedBox(
      width: ekranGenisligi / 2.25,
      height: 53,
      child: ElevatedButton(
        onPressed: () async{
          bool kontrolSonucu=formKey.currentState!.validate();
          if(kontrolSonucu){
            ref.read(authProvider).kayitEkle(context: context, mail: emailController.text, password: passwordController.text, lastName: lastNameController.text, firstName: firstNameController.text, userName: userNameController.text,phoneNumber: phoneNumberController.text);
          }


        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'CREATE',
          style: textTheme.labelLarge?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
