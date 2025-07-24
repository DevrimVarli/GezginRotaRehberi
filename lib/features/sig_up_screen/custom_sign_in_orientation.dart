import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yeni_tasarim/providers/all_providers.dart';

class CustomSignInOrientation extends ConsumerWidget {
  const CustomSignInOrientation({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    bool kayitMi=ref.watch(kayitMiProvider);
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Already have an account?', style: textTheme.bodyMedium),
        TextButton(
            onPressed: (){
              ref.read(kayitMiProvider.notifier).state=!kayitMi;
            }, child: Text('Login here',style: TextStyle(fontSize: 18,color: colorScheme.onSurface,fontWeight: FontWeight.bold),),),
      ],
    );
  }
}
