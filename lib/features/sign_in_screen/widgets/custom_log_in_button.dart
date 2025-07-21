import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/all_providers.dart';
class CustomLogInButton extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  const CustomLogInButton({super.key,required this.formKey});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final ekranGenisligi = MediaQuery.sizeOf(context).width;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);
    return SizedBox(
      width: ekranGenisligi / 2.25,
      height: 53,
      child: ElevatedButton(
        onPressed: () async{
          bool kontrolSonucu=formKey.currentState!.validate();
          if(kontrolSonucu){
            ref.read(authProvider).girisYap(context,emailController.text,passwordController.text);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          "LOG IN",
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
