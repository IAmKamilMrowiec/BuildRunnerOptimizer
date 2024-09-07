import 'dart:io';

import 'package:glob/glob.dart';
import 'package:collection/collection.dart';

class BuilderSettings {
  BuilderSettings._({
    required this.builderKey,
    required this.filePathFilters,
    required this.fileContentFilters,
  });

  factory BuilderSettings.fromRawStrings({
    required String builderKey,
    required List<String> filePathFilters,
    required List<String> fileContentFilters,
  }) {
    return BuilderSettings._(
      builderKey: builderKey,
      fileContentFilters: fileContentFilters.map((e) => RegExp(e)).toList(),
      filePathFilters: filePathFilters.map((e) => Glob(e)).toList(),
    );
  }

  final String builderKey;
  final List<Glob> filePathFilters;
  final List<RegExp> fileContentFilters;

  /// hasMatch by path or by file content
  bool hasAnyMatch(File file, String fileContent) {
    return _hasAnyPathMatch(file) || _hasAnyContentMatch(fileContent);
  }

  /// has GLOB match by path
  bool _hasAnyPathMatch(File file) {
    return filePathFilters == []
        ? false
        : filePathFilters.any((matcher) => matcher.matches(file.path));
  }

  /// has REGEX match by content
  bool _hasAnyContentMatch(String fileContent) {
    return fileContentFilters == []
        ? false
        : fileContentFilters.any((matcher) => matcher.hasMatch(fileContent));
  }

  @override
  int get hashCode =>
      builderKey.hashCode ^
      filePathFilters.hashCode ^
      fileContentFilters.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuilderSettings &&
          runtimeType == other.runtimeType &&
          builderKey == other.builderKey &&
          UnorderedIterableEquality()
              .equals(fileContentFilters, other.fileContentFilters) &&
          UnorderedIterableEquality()
              .equals(filePathFilters, other.filePathFilters);

  @override
  String toString() {
    return 'BuilderSettings(builderKey: $builderKey,filePathFilters: $filePathFilters,fileContentFilters: $fileContentFilters)';
  }
}
