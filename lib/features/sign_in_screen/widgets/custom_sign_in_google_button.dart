import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/all_providers.dart';
class CustomSignInGoogleButton extends ConsumerWidget {
  const CustomSignInGoogleButton({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () async{
          await ref.read(authProvider).signInWithGoogle(context);
        },
        icon: SizedBox(
          width: 20,
          height: 20,
          child: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Google_Favicon_2025.svg/800px-Google_Favicon_2025.svg.png',
          ),
        ),
        label: Text(
          "Sign in with Google",
          style: textTheme.labelLarge?.copyWith(
            color: colorScheme.primary,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: colorScheme.outline),
        ),
      ),
    );
  }
}
