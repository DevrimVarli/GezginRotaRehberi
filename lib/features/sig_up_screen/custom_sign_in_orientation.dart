import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/all_providers.dart';

class CustomSignInOrientation extends ConsumerWidget {
  const CustomSignInOrientation({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final kayitMi=ref.watch(kayitMiProvider);
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account?", style: textTheme.bodyMedium),
        TextButton(
            onPressed: (){
              ref.read(kayitMiProvider.notifier).state=!kayitMi;
            }, child: Text("Login here",style: TextStyle(fontSize: 18,color: colorScheme.onSurface,fontWeight: FontWeight.bold),))
      ],
    );
  }
}
