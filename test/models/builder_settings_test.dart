import 'package:build_runner_optimizer/models/builder_settings.dart';
import 'package:test/test.dart';

void main() {
  group('equality', () {
    group('only builderKey', () {
      test('same', () {
        // Arrange
        final builderKey = 'test:key';
        final a = BuilderSettings(
          builderKey: builderKey,
          filePathRawFilters: [],
          fileContentRawFilters: [],
        );
        final b = BuilderSettings(
          builderKey: builderKey,
          filePathRawFilters: [],
          fileContentRawFilters: [],
        );
        // Act
        // Assert
        expect(a == b, true);
      });
      test('different', () {
        // Arrange
        final a = BuilderSettings(
          builderKey: 'test:key',
          filePathRawFilters: [],
          fileContentRawFilters: [],
        );
        final b = BuilderSettings(
          builderKey: 'another:key',
          filePathRawFilters: [],
          fileContentRawFilters: [],
        );
        // Act
        // Assert
        expect(a == b, false);
      });
    });
    group('filePathRawFilters (same builderKey)', () {
      test('same filePathFilter', () {
        // Arrange
        final builderKey = 'test:key';
        const pathFilter = 'abc';
        final a = BuilderSettings(
          builderKey: builderKey,
          filePathRawFilters: [pathFilter],
          fileContentRawFilters: [],
        );
        final b = BuilderSettings(
          builderKey: builderKey,
          filePathRawFilters: [pathFilter],
          fileContentRawFilters: [],
        );
        // Act
        // Assert
        expect(a == b, true);
      });
      test('different filePathFilter', () {
        // Arrange
        final builderKey = 'test:key';
        final a = BuilderSettings(
          builderKey: builderKey,
          filePathRawFilters: ['abc'],
          fileContentRawFilters: [],
        );
        final b = BuilderSettings(
          builderKey: builderKey,
          filePathRawFilters: ['different key'],
          fileContentRawFilters: [],
        );
        // Act
        // Assert
        expect(a == b, false);
      });
      test('same filePathRawFilters, same order', () {
        // Arrange
        final builderKey = 'test:key';
        const pathFilterOne = 'first';
        const pathFilterTwo = 'second';
        final a = BuilderSettings(
          builderKey: builderKey,
          filePathRawFilters: [pathFilterOne, pathFilterTwo],
          fileContentRawFilters: [],
        );
        final b = BuilderSettings(
          builderKey: builderKey,
          filePathRawFilters: [pathFilterOne, pathFilterTwo],
          fileContentRawFilters: [],
        );
        // Act
        // Assert
        expect(a == b, true);
      });
      test('same filePathRawFilters, different order', () {
        // Arrange
        final builderKey = 'test:key';
        const pathFilterOne = 'first';
        const pathFilterTwo = 'second';
        final a = BuilderSettings(
          builderKey: builderKey,
          filePathRawFilters: [pathFilterOne, pathFilterTwo],
          fileContentRawFilters: [],
        );
        final b = BuilderSettings(
          builderKey: builderKey,
          filePathRawFilters: [pathFilterTwo, pathFilterOne],
          fileContentRawFilters: [],
        );
        // Act
        // Assert
        expect(a == b, true);
      });
    });
    group('fileContentRawFilters (same builderKey and filePathRawFilters)', () {
      test('same fileContentRawFilters', () {
        // Arrange
        final builderKey = 'test:key';
        const pathFilter = 'abc';
        const contentFilter = 'contentFilter';

        final a = BuilderSettings(
          builderKey: builderKey,
          filePathRawFilters: [pathFilter],
          fileContentRawFilters: [contentFilter],
        );
        final b = BuilderSettings(
          builderKey: builderKey,
          filePathRawFilters: [pathFilter],
          fileContentRawFilters: [contentFilter],
        );
        // Act
        // Assert
        expect(a == b, true);
      });
      test('different fileContentRawFilters', () {
        // Arrange
        final builderKey = 'test:key';
        const pathFilter = 'abc';

        final a = BuilderSettings(
          builderKey: builderKey,
          filePathRawFilters: [pathFilter],
          fileContentRawFilters: ['first'],
        );
        final b = BuilderSettings(
          builderKey: builderKey,
          filePathRawFilters: [pathFilter],
          fileContentRawFilters: ['second'],
        );
        // Act
        // Assert
        expect(a == b, false);
      });
      test('same fileContentRawFilters, same order', () {
        // Arrange
        final builderKey = 'test:key';
        const pathFilter = 'abc';

        const fileContentRawFilterFirst = 'First';
        const fileContentRawFilterSecond = 'Second';

        final a = BuilderSettings(
          builderKey: builderKey,
          filePathRawFilters: [pathFilter],
          fileContentRawFilters: [
            fileContentRawFilterFirst,
            fileContentRawFilterSecond,
          ],
        );
        final b = BuilderSettings(
          builderKey: builderKey,
          filePathRawFilters: [pathFilter],
          fileContentRawFilters: [
            fileContentRawFilterFirst,
            fileContentRawFilterSecond,
          ],
        );
        // Act
        // Assert
        expect(a == b, true);
      });
      test('same filePathRawFilters, different order', () {
        // Arrange
        final builderKey = 'test:key';
        const pathFilter = 'abc';

        const fileContentRawFilterFirst = 'First';
        const fileContentRawFilterSecond = 'Second';

        final a = BuilderSettings(
          builderKey: builderKey,
          filePathRawFilters: [pathFilter],
          fileContentRawFilters: [
            fileContentRawFilterFirst,
            fileContentRawFilterSecond,
          ],
        );
        final b = BuilderSettings(
          builderKey: builderKey,
          filePathRawFilters: [pathFilter],
          fileContentRawFilters: [
            fileContentRawFilterSecond,
            fileContentRawFilterFirst,
          ],
        );
        // Act
        // Assert
        expect(a == b, true);
      });
    });
  });
}
