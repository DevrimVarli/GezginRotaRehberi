import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yeni_tasarim/providers/all_providers.dart';
class CustomSignUpButton extends ConsumerWidget {
  const CustomSignUpButton({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    bool kayitMi=ref.watch(kayitMiProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Don't have an account?", style: textTheme.bodyMedium),
        TextButton(
          onPressed: () {
            ref.read(kayitMiProvider.notifier).state=!kayitMi;
          },
          child: Text('Sign Up', style: TextStyle(color: colorScheme.primary)),
        ),
      ],
    );
  }
}
