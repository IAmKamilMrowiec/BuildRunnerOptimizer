import 'package:build_runner_optimizer/models/builder_settings.dart';
import 'package:collection/collection.dart';
import 'package:yaml/yaml.dart';

class OptimizerSettings {
  const OptimizerSettings({
    required this.buildersSettings,
  });

  final List<BuilderSettings> buildersSettings;

  @override
  int get hashCode => UnorderedIterableEquality().hash(buildersSettings);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptimizerSettings &&
          runtimeType == other.runtimeType &&
          UnorderedIterableEquality()
              .equals(buildersSettings, other.buildersSettings);

  factory OptimizerSettings.fromYamlMap(YamlMap map) {
    final buildersConfigs = map.value['builders'] as YamlList;

    return OptimizerSettings(
      buildersSettings: buildersConfigs
          .map((element) => BuilderSettings.fromYamlMap((element as YamlMap)))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'OptimizerSettings(buildersSettings: $buildersSettings)';
  }
}
