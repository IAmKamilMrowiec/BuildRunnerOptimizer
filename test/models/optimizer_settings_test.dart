import 'dart:io';

import 'package:build_runner_optimizer/models/builder_settings.dart';
import 'package:build_runner_optimizer/models/optimizer_settings.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

import 'package:yaml/yaml.dart';

void main() {
  group('OptimizerSettings', () {
    test('empty buildersSettings', () {
      final a = OptimizerSettings(buildersSettings: []);
      final b = OptimizerSettings(buildersSettings: []);

      expect(a == b, true);
    });

    test('same buildersSettings, same order', () {
      final builderSettingsA = BuilderSettings(
        builderKey: 'builderKey',
        filePathRawFilters: ['filePathRawFilters'],
        fileContentRawFilters: ['fileContentRawFilters'],
      );
      final builderSettingsB = BuilderSettings(
        builderKey: 'builderKey',
        filePathRawFilters: ['filePathRawFilters'],
        fileContentRawFilters: ['fileContentRawFilters'],
      );
      final a = OptimizerSettings(
        buildersSettings: [
          builderSettingsA,
          builderSettingsB,
        ],
      );
      final b = OptimizerSettings(
        buildersSettings: [
          builderSettingsA,
          builderSettingsB,
        ],
      );

      expect(builderSettingsA == builderSettingsB, true);
      expect(a == b, true);
    });
    test('same buildersSettings, different order', () {
      final builderSettingsA = BuilderSettings(
        builderKey: 'builderKey',
        filePathRawFilters: ['filePathRawFilters'],
        fileContentRawFilters: ['fileContentRawFilters'],
      );
      final builderSettingsB = BuilderSettings(
        builderKey: 'builderKey',
        filePathRawFilters: ['filePathRawFilters'],
        fileContentRawFilters: ['fileContentRawFilters'],
      );
      final a = OptimizerSettings(
        buildersSettings: [
          builderSettingsA,
          builderSettingsB,
        ],
      );
      final b = OptimizerSettings(
        buildersSettings: [
          builderSettingsB,
          builderSettingsA,
        ],
      );

      expect(builderSettingsA == builderSettingsB, true);
      expect(a == b, true);
    });
  });

  group('YAML parsing', () {
    test('without path filters', () {
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

      final configFile =
          _readYamlConfigFile('config_without_path_filters.yaml');
      final configFileContent = configFile.readAsStringSync();
      final yamlMap = loadYaml(configFileContent) as YamlMap;

      final optimizerSettings = OptimizerSettings.fromYamlMap(yamlMap);

      // Assert

      expect(optimizerSettings.hashCode, expected.hashCode);
    });
  });
}

File _readYamlConfigFile(String fileName) {
  final testConfigsDirPath =
      Directory('${Directory.current.path}/test/test_project')
          .uri
          .normalizePath()
          .path;

  return File(path.join(testConfigsDirPath, fileName));
}
