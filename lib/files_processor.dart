import 'dart:io';

import 'package:build_runner_optimizer/files_reader.dart';
import 'package:build_runner_optimizer/models/builder_files_paths.dart';
import 'package:build_runner_optimizer/models/builder_settings.dart';
import 'package:collection/collection.dart';

class FilesProcessor {
  static List<BuilderFilesLocalPaths> getFilesForBuilder({
    required List<BuilderSettings> builderSettings,
    required String projectRootPath,
  }) {
    final filesPerBuilder = <String, List<File>>{};

    final allFiles = FilesReader.getAllProjectFiles(
      projectRootPath,
    );

    // iterate through all files to minimize the number of file reads
    for (final file in allFiles) {
      final fileContent = file.readAsStringSync();

      final buildersWithMatches = builderSettings.where(
        (builderSetting) => builderSetting.hasAnyMatch(file, fileContent),
      );

      for (final builderSetting in buildersWithMatches) {
        filesPerBuilder[builderSetting.builderKey] = [
          //it may be null so we need to use the null-aware operator
          ...filesPerBuilder[builderSetting.builderKey] ?? [],
          file,
        ];
      }
    }
    return filesPerBuilder.toSortedLocalPaths(
      projectRootPath: projectRootPath,
    );
  }
}

extension on Map<String, List<File>> {
  List<BuilderFilesLocalPaths> toSortedLocalPaths({
    required String projectRootPath,
  }) {
    return entries
        .map(
          (entry) => BuilderFilesLocalPaths(
            builderKey: entry.key,
            localPaths: entry.value
                .map((e) => e.toLocalPath(projectRootPath))
                .sortedBy((localPath) => localPath)
                .toList(),
          ),
        )
        .toList();
  }
}

extension on File {
  String toLocalPath(String projectRootPath) {
    final local = path.substring(projectRootPath.length);
    // we need to remove to remove the leading slash or backslash to have a local path
    if (local.startsWith('/') || local.startsWith('\\')) {
      return local.substring(1);
    }
    return local;
  }
}
