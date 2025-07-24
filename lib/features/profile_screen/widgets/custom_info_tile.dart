import 'package:flutter/material.dart';
class InfoTile extends StatelessWidget {
  const InfoTile(this.title, this.value, {super.key});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.onSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: textTheme.labelLarge?.copyWith(
              color: colorScheme.surface,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.isNotEmpty ? value : 'Bilinmiyor',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.surface.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}
