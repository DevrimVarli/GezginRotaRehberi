import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/profile_screen.dart';
import 'package:yeni_tasarim/screens/security_settings.dart';

/// Kullanıcı profil ekranı.
/// Giriş yapan kullanıcının genel bilgilerini, hesap ayarlarını ve diğer seçenekleri gösterir.
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Bildirim switch durumu
    bool value = ref.watch(checkBoxStateProvider);

    // Ekran genişliği
    double ekranGenisligi = MediaQuery.of(context).size.width;

    // Firebase kullanıcı bilgisi
    User? user = FirebaseAuth.instance.currentUser;

    // Kategori listeleri
    List<String> hesapKategori = ref.watch(generalKategoriProvider);
    List<String> accountKategori = ref.watch(accountKategoriProvider);
    List<String> otherKategori = ref.watch(otherKategoriProvider);

    // Tema bilgileri
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr(), style: GoogleFonts.roboto(fontSize: 24)),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
      ),
      body:
          user == null
              ? const Center(child: Text('Kullanıcı bilgisi bulunamadı.'))
              : Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
                child: ListView(
                  children: <Widget>[
                    // General
                    Text(
                      'general'.tr(),
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ...hesapKategori.map(
                      (String kategori) => buildKategoriSatiri(
                        kategori.tr(),
                        ekranGenisligi,
                        context,
                        colorScheme,
                        textTheme,
                        ref,
                      ),
                    ),

                    // Bildirim ayarı
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        children: <Widget>[
                          ColoredBox(
                            color: colorScheme.surface.withValues(alpha: 0.1),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'notification'.tr(),
                                      style: textTheme.bodyLarge,
                                    ),
                                  ),
                                  Switch.adaptive(
                                    activeColor: colorScheme.onSurface,
                                    activeTrackColor: colorScheme.primary,
                                    inactiveThumbColor: colorScheme.onSurface,
                                    inactiveTrackColor: colorScheme.surface
                                        .withValues(alpha: 0.15),
                                    value: value,
                                    onChanged: (bool val) {
                                      ref
                                          .read(checkBoxStateProvider.notifier)
                                          .state = val;
                                      ref
                                          .read(themeModeProvider.notifier)
                                          .state = val
                                              ? ThemeMode.dark
                                              : ThemeMode.light;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: colorScheme.onSurface.withValues(alpha: 0.2),
                          ),
                        ],
                      ),
                    ),

                    // Account & Security
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'account_security'.tr(),
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ...accountKategori.map(
                      (String kategori) => buildKategoriSatiri(
                        kategori.tr(),
                        ekranGenisligi,
                        context,
                        colorScheme,
                        textTheme,
                        ref,
                      ),
                    ),

                    // Other
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'other'.tr(),
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ...otherKategori.map(
                      (String kategori) => buildKategoriSatiri(
                        kategori.tr(),
                        ekranGenisligi,
                        context,
                        colorScheme,
                        textTheme,
                        ref,
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  /// Kategori satır widget'ı
  Widget buildKategoriSatiri(
    String kategori,
    double ekranGenisligi,
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
    WidgetRef ref,
  ) {
    return GestureDetector(
      onTap: () {
        switch (kategori) {
          case 'Security Settings' || 'Güvenlik Ayarları':
            Navigator.push(
              context,
              MaterialPageRoute<Widget>(
                builder: (_) => const SecuritySettings(),
              ),
            );

          case 'Delete Account' || 'Hesabı Sil':
            ref.read(authProvider).deleteAccount(context);

          case 'Çıkış Yap' || 'Logout':
            FirebaseAuth.instance.signOut();

          case 'Profilim' || 'My Profile':
            Navigator.push(
              context,
              MaterialPageRoute<Widget>(builder: (_) => const ProfileScreen()),
            );
        }
      },
      child: Column(
        children: <Widget>[
          Container(
            color: colorScheme.surface.withValues(alpha: 0.1),
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                Expanded(child: Text(kategori, style: textTheme.bodyLarge)),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: colorScheme.onSurface,
                ),
              ],
            ),
          ),
          Divider(color: colorScheme.onSurface.withValues(alpha: 0.2)),
        ],
      ),
    );
  }
}
