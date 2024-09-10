import 'dart:io';

import 'package:build_runner_optimizer/files_processor.dart';
import 'package:build_runner_optimizer/models/builder_files_paths.dart';
import 'package:build_runner_optimizer/models/builder_settings.dart';
import 'package:test/test.dart';

void main() {
  group(
    'FilesProcessor',
    () {
      late String testFilesPath;

      setUpAll(
        () {
          testFilesPath =
              Directory('${Directory.current.path}/test/test_project')
                  .uri
                  .normalizePath()
                  .path;
        },
      );
      group('single builder', () {
        group(('path filters'), () {
          test('nested and root', () {
            // Arrange
            final builderSettings = BuilderSettings(
              builderKey: 'testKey',
              filePathRawFilters: [
                '**_api.dart',
              ],
              fileContentRawFilters: [],
            );

            // Act
            final filesForTestBuilder = FilesProcessor.getFilesForBuilder(
              builderSettings: [builderSettings],
              projectRootPath: testFilesPath,
            );

            final expected = [
              BuilderFilesLocalPaths(
                builderKey: 'testKey',
                localPaths: [
                  'lib/nested_api/user_api.dart',
                  'lib/user_api.dart',
                ],
              )
            ];

            // Assert
            expect(filesForTestBuilder, expected);
          });
        });
      });
      group('content filters', () {
        test('gets all files', () {
          // Arrange
          final builderSettings = BuilderSettings(
            builderKey: 'testKey',
            filePathRawFilters: [],
            fileContentRawFilters: [
              r'toJson()',
              r'fromJson()',
            ],
          );

          // Act
          final filesForTestBuilder = FilesProcessor.getFilesForBuilder(
            builderSettings: [builderSettings],
            projectRootPath: testFilesPath,
          ).first;

          final expected = BuilderFilesLocalPaths(
            builderKey: 'testKey',
            localPaths: [
              'lib/nested_serialized/nested_serialized_from.dart',
              'lib/nested_serialized/nested_serialized_to.dart',
              'lib/serialized.dart',
            ],
          );

          // Assert
          expect(filesForTestBuilder, expected);
        });
      });
      group('content and path filters', () {
        test('gets all files', () {
          // Arrange
          final builderSettings = BuilderSettings(
            builderKey: 'testKey',
            filePathRawFilters: [
              '**/**_serialized**',
              '**/lib/serialized**',
            ],
            fileContentRawFilters: [
              r'@freezed()',
            ],
          );

          // Act
          final filesForTestBuilder = FilesProcessor.getFilesForBuilder(
            builderSettings: [builderSettings],
            projectRootPath: testFilesPath,
          ).first;

          final expected = BuilderFilesLocalPaths(
            builderKey: 'testKey',
            localPaths: [
              'lib/file_with_two_constructors.dart',
              'lib/nested_serialized/nested_serialized_from.dart',
              'lib/nested_serialized/nested_serialized_to.dart',
              'lib/nested_with_two_constructors/file_with_two_constructors.dart',
              'lib/serialized.dart',
            ],
          );

          // Assert
          expect(filesForTestBuilder, expected);
        });
        test('do not duplicate entries', () {
          // Arrange
          final builderSettings = BuilderSettings(
            builderKey: 'testKey',
            filePathRawFilters: [
              '**/lib/file_with_two_constructors**',
            ],
            fileContentRawFilters: [
              r'class RootUser',
            ],
          );

          // Act
          final filesForTestBuilder = FilesProcessor.getFilesForBuilder(
            builderSettings: [builderSettings],
            projectRootPath: testFilesPath,
          ).first;

          final expected = BuilderFilesLocalPaths(
            builderKey: 'testKey',
            localPaths: [
              'lib/file_with_two_constructors.dart',
            ],
          );

          // Assert
          expect(filesForTestBuilder, expected);
        });
      });
    },
  );
}
