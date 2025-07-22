import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/profile_screen.dart';
import 'package:yeni_tasarim/screens/security_settings.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(checkBoxStateProvider);
    double ekranGenisligi = MediaQuery.of(context).size.width;
    final user = FirebaseAuth.instance.currentUser;
    final hesapKategori = ref.watch(generalKategoriProvider);
    final accountKategori = ref.watch(accountKategoriProvider);
    final otherKategori = ref.watch(otherKategoriProvider);
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;

    return Scaffold(
        appBar: AppBar(
          title: Text("Profile", style: GoogleFonts.roboto(fontSize: 24,)),
          centerTitle: true,
          backgroundColor: colorScheme.surface,
        ),
        body: user == null
            ? Center(child: Text("Kullanıcı bilgisi bulunamadı."))
            :Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
            child: ListView(
              children: [
                Text("General",style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),),
                ...hesapKategori.map((kategori) => buildKategoriSatiri(
                  kategori,
                  ekranGenisligi,
                  context,
                  colorScheme,
                  textTheme,
                  ref,
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Column(
                    children: [
                      Container(
                        color: colorScheme.surface.withValues(alpha: 0.1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Notification",
                                  style: textTheme.bodyLarge,
                                ),
                              ),
                              Switch.adaptive(
                                activeColor: colorScheme.onSurface,
                                activeTrackColor: colorScheme.primary,
                                inactiveThumbColor: colorScheme.onSurface,
                                inactiveTrackColor: colorScheme.surface.withValues(alpha: 0.15),
                                value: value,
                                onChanged: (val) {
                                  ref.read(checkBoxStateProvider.notifier).state = val;
                                  ref.read(themeModeProvider.notifier).state=val?ThemeMode.dark:ThemeMode.light;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: ekranGenisligi,
                        color: colorScheme.onSurface.withValues(alpha: 0.2),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text("Account & Security",style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),),
                ),
                ...accountKategori.map((kategori) => buildKategoriSatiri(
                  kategori,
                  ekranGenisligi,
                  context,
                  colorScheme,
                  textTheme,
                  ref,
                )),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text("Other",style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),),
                ),
                ...otherKategori.map((kategori) => buildKategoriSatiri(
                  kategori,
                  ekranGenisligi,
                  context,
                  colorScheme,
                  textTheme,
                  ref,
                )),
              ],
            ),
          ),
        ),

    );
  }
  Widget buildKategoriSatiri(
      var kategori,
      double ekranGenisligi,
      BuildContext context,
      ColorScheme colorScheme,
      TextTheme textTheme,
      WidgetRef ref,
      ) {
    return GestureDetector(
      onTap: () {
        switch (kategori){
            case "Security Settings":Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecuritySettings()),
            );
              break;
            case "Delete Account": ref.read(authProvider).deleteAccount(context);
              break;
            case "Çıkış Yap":FirebaseAuth.instance.signOut();
              break;
            case "Profilim":Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
              break;
        }

      },
      child: Column(
        children: [
          Container(
            color: colorScheme.surface.withValues(alpha: 0.1),
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    kategori,
                    style: textTheme.bodyLarge,
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    size: 18, color: colorScheme.onSurface),
              ],
            ),
          ),
          Container(
            height: 1,
            width: ekranGenisligi,
            color: colorScheme.onSurface.withValues(alpha: 0.2),
          ),
        ],
      ),
    );
  }

}