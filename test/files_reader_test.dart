import 'dart:io';

import 'package:build_runner_optimizer/project_files_reader.dart';
import 'package:test/test.dart';

void main() {
  group('FilesReader', () {
    test('getAllProjectLibDartFiles', () {
      // Arrange
      final filesCount = 8;
      final testFilesPath =
          Directory('${Directory.current.path}/test/test_files/')
              .uri
              .normalizePath();

      // Act
      final allTestFiles =
          ProjectFilesReader.getAllProjectFiles(testFilesPath.path);

      // Assert
      expect(allTestFiles.length, filesCount);
    });
    test('getNestedApiFiles', () {
      // Arrange
      final filesCount = 2;
      final testFilesPath =
          Directory('${Directory.current.path}/test/test_files/lib/nested_api')
              .uri
              .normalizePath();

      // Act
      final allTestFiles =
          ProjectFilesReader.getAllProjectFiles(testFilesPath.path);

      // Assert
      expect(allTestFiles.length, filesCount);
    });
  });
}
