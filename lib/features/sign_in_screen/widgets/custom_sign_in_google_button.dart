import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';

class CustomSignInGoogleButton extends ConsumerWidget {
  const CustomSignInGoogleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tema renk şeması ve metin stillerini alıyoruz
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width:
          double
              .infinity, // Butonun genişliğini ekranın tamamına yayacak şekilde ayarlıyoruz
      child: OutlinedButton.icon(
        onPressed: () async {
          // Butona tıklandığında Google ile giriş yapmayı başlatıyoruz
          await ref.read(authProvider).signInWithGoogle(context);
        },
        icon: SizedBox(
          width: 20, // Google ikonunun genişliği
          height: 20, // Google ikonunun yüksekliği
          child: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Google_Favicon_2025.svg/800px-Google_Favicon_2025.svg.png', // Google ikonunun URL'si
          ),
        ),
        label: Text(
          'google_sign_in'.tr(), // Butonun metni
          style: textTheme.labelLarge?.copyWith(
            color:
                colorScheme
                    .primary, // Metnin rengi, tema renk şeması ile uyumlu
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ), // Butonun dikeydeki iç boşluğu
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              12,
            ), // Butonun yuvarlatılmış köşeleri
          ),
          side: BorderSide(
            color: colorScheme.outline,
          ), // Butonun kenarının rengi, tema ile uyumlu
        ),
      ),
    );
  }
}
