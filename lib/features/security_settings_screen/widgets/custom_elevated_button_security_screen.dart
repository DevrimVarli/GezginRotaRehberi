import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/services/auth_service.dart';
class CustomElevatedButtonSecurityScreen extends ConsumerWidget {
  const CustomElevatedButtonSecurityScreen({super.key,required this.mailController,required this.passwordController,required this.newPasswordController,required this.formKey});
 final  TextEditingController mailController ;
 final  TextEditingController passwordController ;
 final  TextEditingController newPasswordController;
 final  GlobalKey<FormState> formKey;


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    double ekranGenisligi = MediaQuery.of(context).size.width;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    User user=FirebaseAuth.instance.currentUser!;
    return SizedBox(
      width: ekranGenisligi/1.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
        ),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            AuthService auth = ref.read(authProvider);
            if (mailController.text != user.email) {
              await auth.changeEmail(
                newEmail: mailController.text,
                currentPassword: passwordController.text,
                context: context,
              );
            }
            if (newPasswordController.text.isNotEmpty) {
              if (!context.mounted) return;
              await auth.changePassword(
                currentPassword: passwordController.text,
                newPassword: newPasswordController.text,
                context: context,
              );
            }
          }
        },
        child: Text('Kaydet',style:textTheme.headlineSmall?.copyWith(color:Colors.white,fontWeight: FontWeight.w400),),
      ),
    );
  }
}
