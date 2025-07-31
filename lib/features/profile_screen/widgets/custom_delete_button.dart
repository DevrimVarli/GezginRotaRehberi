import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
class CustomDeleteButton extends ConsumerWidget {
  const CustomDeleteButton({super.key, required this.firestoreData});
  final Map<String, dynamic> firestoreData;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon(Icons.delete, size: 20, color: Colors.red),
          onPressed: () {
            ref.read(authProvider).photoDelete(imageUrl:firestoreData['profile_picture'].toString().isNotEmpty? "${firestoreData['profile_picture']}":'' );
          },
        ),
      ),
    );
  }
}
