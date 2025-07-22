import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/services/validator.dart';
class SecuritySettings extends ConsumerWidget {
  const SecuritySettings({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final mailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);
    final newPasswordController = ref.watch(newPasswordControllerProvider);
    final key = GlobalKey<FormState>();
    double ekranGenisligi = MediaQuery.of(context).size.width;
    mailController.text = FirebaseAuth.instance.currentUser!.email!;
    var user=FirebaseAuth.instance.currentUser!;
    return FutureBuilder<Map<String, dynamic>?>(
      future: ref.read(authProvider).getFirestoreUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text("Kullanıcı verileri alınamadı."));
        }

        final data = snapshot.data!;
        final firstName = data["firstName"] ?? "";
        final lastName = data["lastName"] ?? "";

        return Scaffold(
          appBar: AppBar(
            title: Text('Güvenlik Ayarları', style: textTheme.headlineSmall),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
            child: Column(
              children: [
                // Profil fotoğrafı ve isimler
                CircleAvatar(
                  radius: 60,
                  backgroundImage: user.photoURL != null
                      ? NetworkImage(user.photoURL!)
                      : const NetworkImage("https://sunnysmilesep.com/wp-content/uploads/2019/05/AdobeStock_214746128-1024x683.jpeg"),
                ),
                const SizedBox(height: 16),
                Text("$firstName $lastName", style: textTheme.headlineSmall),
                Text(user.email ?? "", style: textTheme.bodyLarge),

                const SizedBox(height: 32),

                // Form alanları
                Form(
                  key: key,
                  child: Column(
                    children: [
                      buildTextFormField(
                        tfc: mailController,
                        validator: mailValidator,
                        hintText: "Email",
                        obscureText: false,
                        icon: const Icon(Icons.mail),
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 16),
                      buildTextFormField(
                        tfc: passwordController,
                        validator: passValidator,
                        hintText: "Current Password",
                        obscureText: true,
                        icon: const Icon(Icons.lock),
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 16),
                      buildTextFormField(
                        tfc: newPasswordController,
                        validator: passValidator2,
                        hintText: "New Password",
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
                        final auth = ref.read(authProvider);
                        if (mailController.text != user.email) {
                          await auth.changeEmail(
                            newEmail: mailController.text,
                            currentPassword: passwordController.text,
                          );
                        }
                        if (newPasswordController.text.isNotEmpty) {
                          await auth.changePassword(
                            currentPassword: passwordController.text,
                            newPassword: newPasswordController.text,
                          );
                        }
                      }
                    },
                    child: Text("Kaydet",style:textTheme.headlineSmall?.copyWith(color: colorScheme.onSurface,fontWeight: FontWeight.w400),),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
