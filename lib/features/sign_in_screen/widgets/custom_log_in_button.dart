import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yeni_tasarim/providers/all_providers.dart';

class CustomLogInButton extends ConsumerStatefulWidget {
  const CustomLogInButton({super.key,required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  ConsumerState<CustomLogInButton> createState() => _CustomLogInButtonState();
}

class _CustomLogInButtonState extends ConsumerState<CustomLogInButton> {
  @override
  Widget build(BuildContext context) {
    double ekranGenisligi = MediaQuery.sizeOf(context).width;
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    TextEditingController emailController=ref.watch(emailControllerProvider);
    TextEditingController passwordController=ref.watch(passwordControllerProvider);
    return SizedBox(
      width: ekranGenisligi / 2.25,
      height: ekranYuksekligi / 17,
      child: ElevatedButton(
        onPressed: () async{
          bool kontrolSonucu=widget.formKey.currentState!.validate();
          if(kontrolSonucu){
            await ref.read(authProvider).girisYap(context: context,email:emailController.text,password:passwordController.text);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'LOG IN',
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

