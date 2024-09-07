import 'dart:io';

class FilesReader {
  static Set<File> getAllProjectFiles(String filesPath) {
    final allFiles = Directory(filesPath)
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .toSet();

    return allFiles;
  }
}
