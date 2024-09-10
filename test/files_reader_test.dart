import 'dart:io';

import 'package:build_runner_optimizer/files_reader.dart';
import 'package:test/test.dart';

void main() {
  group('FilesReader', () {
    test('getAllProjectFiles', () {
      // Arrange
      final filesCount = 8;
      final testFilesPath =
          Directory('${Directory.current.path}/test/test_project/lib')
              .uri
              .normalizePath();

      // Act
      final allTestFiles = FilesReader.getAllProjectFiles(testFilesPath.path);

      // Assert
      expect(allTestFiles.length, filesCount);
    });
    test('getNestedApiFiles', () {
      // Arrange
      final filesCount = 2;
      final testFilesPath = Directory(
              '${Directory.current.path}/test/test_project/lib/nested_api')
          .uri
          .normalizePath();

      // Act
      final allTestFiles = FilesReader.getAllProjectFiles(testFilesPath.path);

      // Assert
      expect(allTestFiles.length, filesCount);
    });
  });
}
