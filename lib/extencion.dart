import 'dart:io';

import 'package:flutter/material.dart';

void main() async {
  final directory = Directory('lib');
  final regex = RegExp(r'''(['"])(.*?)(?<!\\)\1'''); // Tek/çift tırnaklı stringleri yakalar
  final outputFile = File('lib/string_output.txt');
  final sink = outputFile.openWrite();

  final dartFiles = await directory
      .list(recursive: true)
      .where((entity) {
    if (entity is! File) return false;

    final path = entity.path;
    final fileName = path.split('/').last;

    // Dosya adında filtrele
    return path.endsWith('.dart') &&
        !fileName.contains('_model') &&
        !fileName.contains('.freezed.dart') &&
        !fileName.contains('.g.dart');
  })
      .cast<File>()
      .toList();

  for (final file in dartFiles) {
    final lines = await file.readAsLines();
    bool fileHasMatch = false;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      // Satırda bu ifadeler varsa atla
      if (line.contains('package:') || line.contains('.g.dart')) continue;

      final matches = regex.allMatches(line);

      for (final match in matches) {
        final value = match.group(0);
        final path = file.path;
        final lineNumber = i + 1;

        if (!fileHasMatch) {
          sink.writeln('\n📄 $path');
          fileHasMatch = true;
        }

        sink.writeln('  👉 $lineNumber: $value');
      }
    }
  }

  await sink.flush();
  await sink.close();

  debugPrint('\n✅ Tüm string ifadeler "lib/string_output.txt" dosyasına yazıldı.');
}