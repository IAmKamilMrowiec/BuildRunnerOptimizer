import 'dart:io';
import 'package:build_runner_optimizer/models/builder_settings.dart';
import 'package:path/path.dart' as path;

import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('BuilderSettings parsing test', () {
    test('without path filters', () {
      // Arrange
      final expected = [
        BuilderSettings.fromRawStrings(
          builderKey: 'test:key',
          fileContentFilters: ['part ".*.g.dart";'],
          filePathFilters: [],
        )
      ];

      // Act

      final configFile =
          _readYamlConfigFile('config_without_path_filters.yaml');
      final configFileContent = configFile.readAsStringSync();
      final yamlMap = loadYaml(configFileContent) as YamlMap;

      final yamlList = yamlMap.value['build_runner_optimizer'] as YamlList;

      final builderConfigs = parseBuilderSettingsFromYamlList(yamlList);
      for (final config in builderConfigs) {
        print(config);
      }

      // Assert
    });
  });
}

Lsit<BuilderSettings> _parseConfigsFromTestFile(String testFileName) {
  final configFile = _readYamlConfigFile('config_without_path_filters.yaml');
  final configFileContent = configFile.readAsStringSync();
  final yamlMap = loadYaml(configFileContent) as YamlMap;

  final yamlList = yamlMap.value['build_runner_optimizer'] as YamlList;

  final builderConfigs = parseBuilderSettingsFromYamlList(yamlList);
  for (final config in builderConfigs) {
    print(config);
  }
}

File _readYamlConfigFile(String fileName) {
  final testConfigsDirPath =
      Directory('${Directory.current.path}/test/test_config_files')
          .uri
          .normalizePath()
          .path;

  return File(path.join(testConfigsDirPath, fileName));
}
