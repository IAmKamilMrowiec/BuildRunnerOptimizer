import 'dart:io';

import 'package:build_runner_optimizer/models/optimizer_settings.dart';
import 'package:yaml/yaml.dart';

class FilesReader {
  static Set<File> getAllProjectFiles(String filesPath) {
    final allFiles = Directory(filesPath)
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .toSet();

    return allFiles;
  }

  static OptimizerSettings getOptimizerSettings(String configFilePath) {
    final configFile = File(configFilePath);
    final configFileContent = configFile.readAsStringSync();
    final configYamlMap = loadYaml(configFileContent) as YamlMap;

    return OptimizerSettings.fromYamlMap(configYamlMap);
  }
}
