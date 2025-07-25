import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/services/auth_service.dart';
import 'package:yeni_tasarim/services/validator.dart';
class SecuritySettings extends ConsumerWidget {
  const SecuritySettings({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextEditingController mailController = ref.watch(emailControllerProvider);
    TextEditingController passwordController = ref.watch(passwordControllerProvider);
    TextEditingController newPasswordController = ref.watch(newPasswordControllerProvider);
    GlobalKey<FormState> key = GlobalKey<FormState>();
    double ekranGenisligi = MediaQuery.of(context).size.width;
    mailController.text = FirebaseAuth.instance.currentUser!.email!;
    User user=FirebaseAuth.instance.currentUser!;
    return ref.read(authProvider).kullaniciyiBul()?FutureBuilder<Map<String, dynamic>?>(
      future: ref.read(authProvider).getFirestoreUserData(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text('Kullanıcı verileri alınamadı.'));
        }

        Map<String, dynamic> data = snapshot.data!;
        String firstName = data['firstName'].toString();
        String lastName = data['lastName'].toString();

        return Scaffold(
          appBar: AppBar(
            title: Text('Güvenlik Ayarları', style: textTheme.headlineSmall),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
            child: Column(
              children: <Widget>[
                // Profil fotoğrafı ve isimler
                CircleAvatar(
                  radius: 60,
                  backgroundImage: user.photoURL != null
                      ? NetworkImage(user.photoURL!)
                      :  NetworkImage(data['profile_picture'].toString()),
                ),
                const SizedBox(height: 16),
                Text('$firstName $lastName', style: textTheme.headlineSmall),
                Text(user.email ?? '', style: textTheme.bodyLarge),

                const SizedBox(height: 32),

                // Form alanları
                Form(
                  key: key,
                  child: Column(
                    children: <Widget>[
                      buildTextFormField(
                        tfc: mailController,
                        validator: mailValidator,
                        hintText: 'Email',
                        obscureText: false,
                        icon: const Icon(Icons.mail),
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 16),
                      buildTextFormField(
                        tfc: passwordController,
                        validator: passValidator,
                        hintText: 'Current Password',
                        obscureText: true,
                        icon: const Icon(Icons.lock),
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 16),
                      buildTextFormField(
                        tfc: newPasswordController,
                        validator: passValidator2,
                        hintText: 'New Password',
                        obscureText: true,
                        icon: const Icon(Icons.lock_outline),
                        colorScheme: colorScheme,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                SizedBox(
                  width: ekranGenisligi/1.5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                    ),
                    onPressed: () async {
                      if (key.currentState!.validate()) {
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
                ),
              ],
            ),
          ),
        );
      },
    ): Scaffold(
      appBar: AppBar(
        title: Text('Güvenlik Ayarları', style: textTheme.headlineSmall),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          children: <Widget>[
            // Profil fotoğrafı ve isimler
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(user.photoURL.toString())
            ),
            const SizedBox(height: 16),
            Text(user.displayName.toString(), style: textTheme.headlineSmall),
            Text(user.email ?? '', style: textTheme.bodyLarge),

            const SizedBox(height: 32),

            // Form alanları
            Form(
              key: key,
              child: Column(
                children: <Widget>[
                  buildTextFormField(
                    tfc: mailController,
                    validator: mailValidator,
                    hintText: 'Email',
                    obscureText: false,
                    icon: const Icon(Icons.mail),
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(height: 16),
                  buildTextFormField(
                    tfc: passwordController,
                    validator: passValidator,
                    hintText: 'Current Password',
                    obscureText: true,
                    icon: const Icon(Icons.lock),
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(height: 16),
                  buildTextFormField(
                    tfc: newPasswordController,
                    validator: passValidator2,
                    hintText: 'New Password',
                    obscureText: true,
                    icon: const Icon(Icons.lock_outline),
                    colorScheme: colorScheme,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: ekranGenisligi/1.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                ),
                onPressed: () async {
                  if (key.currentState!.validate()) {
                    AuthService auth = ref.read(authProvider);
                    if (mailController.text != user.email) {
                      await auth.changeEmail(
                        context: context,
                        newEmail: mailController.text,
                        currentPassword: passwordController.text,
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
                child: Text('Kaydet',style:textTheme.headlineSmall?.copyWith(color: colorScheme.onSurface,fontWeight: FontWeight.w400),),
              ),
            ),
          ],
        ),
      ),
    );

  }
  Widget buildTextFormField({
    required String hintText,
    required bool obscureText,
    required Icon icon,
    required TextEditingController tfc,
    required String? Function(String?) validator,
    required ColorScheme colorScheme,
  }){
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller:tfc ,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),);

  }
}
