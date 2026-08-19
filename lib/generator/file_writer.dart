import 'dart:io';

class FileWriter {
  Future<void> write({
    required String directory,
    required String fileName,
    required String content,
  }) async {
    final dir = Directory(directory);

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final file = File("$directory/$fileName");

    await file.writeAsString(content);

    print("✔ Generated: ${file.path}");
  }
}