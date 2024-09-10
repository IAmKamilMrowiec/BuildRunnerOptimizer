import 'dart:io';

import 'package:glob/glob.dart';
import 'package:collection/collection.dart';
import 'package:yaml/yaml.dart';

const builderKeyYamlKey = 'builder_key';
const fileContentFiltersYamlKey = 'content_filters';
const filePathRawFiltersYamlKey = 'path_filters';

class BuilderSettings {
  BuilderSettings({
    required this.builderKey,
    required this.filePathRawFilters,
    required this.fileContentRawFilters,
  });

  factory BuilderSettings.fromYamlMap(YamlMap map) {
    final builderKey = map[builderKeyYamlKey] as String;

    final fileContentRawFilters =
        (map[fileContentFiltersYamlKey] as YamlList? ?? [])
            .map((e) => e as String);

    final filePathRawFilters =
        (map[filePathRawFiltersYamlKey] as YamlList? ?? [])
            .map((e) => e as String);

    return BuilderSettings(
      builderKey: builderKey,
      fileContentRawFilters: fileContentRawFilters.toList(),
      filePathRawFilters: filePathRawFilters.toList(),
    );
  }

  final String builderKey;
  final List<String> filePathRawFilters;
  final List<String> fileContentRawFilters;

  /// hasMatch by path or by file content
  bool hasAnyMatch(File file, String fileContent) =>
      _hasAnyPathMatch(file) || _hasAnyContentMatch(fileContent);

  /// has GLOB match by path
  bool _hasAnyPathMatch(File file) {
    for (var rawFilter in filePathRawFilters) {
      final glob = Glob(rawFilter);
      if (glob.matches(file.path)) {
        return true;
      }
    }
    return false;
  }

  /// has REGEX match by content
  bool _hasAnyContentMatch(String fileContent) {
    for (var rawFilter in fileContentRawFilters) {
      final regExp = RegExp(rawFilter);
      if (regExp.hasMatch(fileContent)) {
        return true;
      }
    }
    return false;
  }

  @override
  int get hashCode =>
      builderKey.hashCode ^
      UnorderedIterableEquality().hash(filePathRawFilters) ^
      UnorderedIterableEquality().hash(fileContentRawFilters);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuilderSettings &&
          runtimeType == other.runtimeType &&
          builderKey == other.builderKey &&
          UnorderedIterableEquality()
              .equals(fileContentRawFilters, other.fileContentRawFilters) &&
          UnorderedIterableEquality()
              .equals(filePathRawFilters, other.filePathRawFilters);

  @override
  String toString() {
    return 'BuilderSettings(builderKey: $builderKey,filePathRawFilters: $filePathRawFilters,fileContentRawFilters: $fileContentRawFilters)';
  }
}
