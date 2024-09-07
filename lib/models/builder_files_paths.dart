import 'package:collection/collection.dart';

class BuilderFilesLocalPaths {
  BuilderFilesLocalPaths({
    required this.builderKey,
    required this.localPaths,
  });

  final String builderKey;
  // we need to use List instead of Set because we need to keep the order
  final List<String> localPaths;

  @override
  int get hashCode => builderKey.hashCode ^ localPaths.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuilderFilesLocalPaths &&
          runtimeType == other.runtimeType &&
          builderKey == other.builderKey &&
          UnorderedIterableEquality().equals(localPaths, other.localPaths);

  @override
  String toString() {
    return 'BuilderFilesLocalPaths(builderKey: $builderKey,localPaths: $localPaths)';
  }
}
