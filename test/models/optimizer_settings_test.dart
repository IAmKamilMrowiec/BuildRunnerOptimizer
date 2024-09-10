import 'package:build_runner_optimizer/models/builder_settings.dart';
import 'package:build_runner_optimizer/models/optimizer_settings.dart';
import 'package:test/test.dart';

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
}
