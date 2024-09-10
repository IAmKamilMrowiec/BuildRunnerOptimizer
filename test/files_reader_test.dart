import 'dart:io';

import 'package:build_runner_optimizer/files_reader.dart';
import 'package:test/test.dart';
import 'package:build_runner_optimizer/models/builder_settings.dart';
import 'package:build_runner_optimizer/models/optimizer_settings.dart';
import 'package:path/path.dart' as path;

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

  group('YAML parsing', () {
    test('config_without_path_filters', () {
      // Arrange
      final expected = OptimizerSettings(
        buildersSettings: [
          BuilderSettings(
            builderKey: 'test:key',
            fileContentRawFilters: ['part ".*.g.dart";'],
            filePathRawFilters: [],
          )
        ],
      );

      // Act

      final optimizerSettings = FilesReader.getOptimizerSettings(
          _getYamlConfigFilePath('config_without_path_filters.yaml'));

      // Assert
      expect(optimizerSettings, expected);
    });
    test('config_without_content_filters', () {
      // Arrange
      final expected = OptimizerSettings(
        buildersSettings: [
          BuilderSettings(
            builderKey: 'test:key',
            fileContentRawFilters: [],
            filePathRawFilters: [
              'lib/**',
              'test/**',
            ],
          )
        ],
      );

      // Act

      final optimizerSettings = FilesReader.getOptimizerSettings(
          _getYamlConfigFilePath('config_without_content_filters.yaml'));

      // Assert
      expect(optimizerSettings, expected);
    });
    test('config_with_one_correct_config', () {
      // Arrange
      final expected = OptimizerSettings(
        buildersSettings: [
          BuilderSettings(
            builderKey: 'test:key',
            fileContentRawFilters: ['part ".*.g.dart";'],
            filePathRawFilters: [
              'lib/**',
              'test/**',
            ],
          )
        ],
      );

      // Act

      final optimizerSettings = FilesReader.getOptimizerSettings(
          _getYamlConfigFilePath('config_with_one_correct_config.yaml'));

      // Assert
      expect(optimizerSettings, expected);
    });
    test('config_with_two_correct_configs', () {
      // Arrange
      final expected = OptimizerSettings(
        buildersSettings: [
          BuilderSettings(
            builderKey: 'test:key',
            fileContentRawFilters: ['part ".*.g.dart";'],
            filePathRawFilters: [
              'lib/**',
              'test/**',
            ],
          ),
          BuilderSettings(
            builderKey: 'secondKey',
            fileContentRawFilters: ['toJson()'],
            filePathRawFilters: [
              '**/**dto.dart',
            ],
          )
        ],
      );

      // Act

      final optimizerSettings = FilesReader.getOptimizerSettings(
          _getYamlConfigFilePath('config_with_two_correct_configs.yaml'));

      // Assert
      expect(optimizerSettings, expected);
    });
  });
}

String _getYamlConfigFilePath(String fileName) {
  final testConfigsDirPath =
      Directory('${Directory.current.path}/test/test_project')
          .uri
          .normalizePath()
          .path;

  return path.join(testConfigsDirPath, fileName);
}
