// Copyright © 2025 Monster Spawned Studios
// https://monsterspawned.studio/
// All rights reserved.

import 'dart:io';

void main(List<String> args) {
  final copyrightFile = File('docs/COPYRIGHT');
  if (!copyrightFile.existsSync()) {
    print('Error: docs/COPYRIGHT file not found');
    exit(1);
  }

  final copyrightContent = copyrightFile.readAsStringSync();
  final copyrightHeader = _formatCopyrightHeader(copyrightContent);

  final directories = ['lib', 'test', 'integration_test', 'android', 'ios', 'web', 'windows', 'macos', 'linux'];
  final extensions = ['.dart', '.yaml', '.yml', '.gradle', '.swift', '.kt', '.java'];

  final filesProcessed = 0;
  final filesSkipped = 0;

  for (final directory in directories) {
    final dir = Directory(directory);
    if (dir.existsSync()) {
      _processDirectory(dir, extensions, copyrightHeader, filesProcessed, filesSkipped);
    }
  }

  print('Copyright header processing complete:');
  print('Files processed: $filesProcessed');
  print('Files skipped: $filesSkipped');
}

void _processDirectory(Directory dir, List<String> extensions, String copyrightHeader, int filesProcessed, int filesSkipped) {
  final entities = dir.listSync(recursive: true);

  for (final entity in entities) {
    if (entity is File) {
      final filePath = entity.path;
      final extension = _getFileExtension(filePath);

      if (extensions.contains(extension)) {
        if (_addCopyrightHeader(entity, copyrightHeader, extension)) {
          filesProcessed++;
        } else {
          filesSkipped++;
        }
      }
    }
  }
}

String _getFileExtension(String filePath) {
  final lastDot = filePath.lastIndexOf('.');
  if (lastDot == -1) return '';
  return filePath.substring(lastDot);
}

bool _addCopyrightHeader(File file, String copyrightHeader, String extension) {
  try {
    final content = file.readAsStringSync();

    // Skip if file already has copyright header
    if (content.contains('Copyright ©') && content.contains('Monster Spawned Studios')) {
      return false;
    }

    String newContent;
    switch (extension) {
      case '.dart':
        newContent = _addDartCopyright(content, copyrightHeader);
        break;
      case '.yaml':
      case '.yml':
        newContent = _addYamlCopyright(content, copyrightHeader);
        break;
      case '.gradle':
      case '.kt':
      case '.java':
        newContent = _addJavaCopyright(content, copyrightHeader);
        break;
      case '.swift':
        newContent = _addSwiftCopyright(content, copyrightHeader);
        break;
      default:
        newContent = _addGenericCopyright(content, copyrightHeader);
    }

    file.writeAsStringSync(newContent);
    print('Added copyright header to: ${file.path}');
    return true;
  } catch (e) {
    print('Error processing ${file.path}: $e');
    return false;
  }
}

String _formatCopyrightHeader(String copyrightContent) {
  final lines = copyrightContent.split('\n');
  return lines.map((line) => line.trim()).where((line) => line.isNotEmpty).join('\n');
}

String _addDartCopyright(String content, String copyright) {
  final lines = copyright.split('\n');
  final dartCopyright = lines.map((line) => '// $line').join('\n');
  return '$dartCopyright\n\n$content';
}

String _addYamlCopyright(String content, String copyright) {
  final lines = copyright.split('\n');
  final yamlCopyright = lines.map((line) => '# $line').join('\n');
  return '$yamlCopyright\n\n$content';
}

String _addJavaCopyright(String content, String copyright) {
  final lines = copyright.split('\n');
  final javaCopyright = lines.map((line) => '// $line').join('\n');
  return '$javaCopyright\n\n$content';
}

String _addSwiftCopyright(String content, String copyright) {
  final lines = copyright.split('\n');
  final swiftCopyright = lines.map((line) => '// $line').join('\n');
  return '$swiftCopyright\n\n$content';
}

String _addGenericCopyright(String content, String copyright) {
  final lines = copyright.split('\n');
  final genericCopyright = lines.map((line) => '# $line').join('\n');
  return '$genericCopyright\n\n$content';
}
