import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  const shellFeature = 'shell_smoke_feature';
  const dartFeature = 'dart_smoke_feature';

  final repoRoot = Directory.current.path;
  final shellGeneratorPath = '$repoRoot/generate_feature.sh';
  final dartGeneratorPath = '$repoRoot/lib/core/cli/feature_generator.dart';

  group('feature generators', () {
    test('shell generator creates clean-architecture riverpod files', () async {
      final tempDir = await Directory.systemTemp.createTemp('shell_generator_test_');
      addTearDown(() async {
        if (await tempDir.exists()) {
          await tempDir.delete(recursive: true);
        }
      });

      final result = await Process.run(
        'bash',
        [shellGeneratorPath, '--name', shellFeature],
        workingDirectory: tempDir.path,
      );

      expect(result.exitCode, 0, reason: 'shell generator failed: ${result.stderr}');

      final featureDir = Directory('${tempDir.path}/lib/features/$shellFeature');
      expect(await featureDir.exists(), isTrue);

      await _expectFilesExist(featureDir.path, [
        'data/datasources/${shellFeature}_remote_data_source.dart',
        'data/repositories/${shellFeature}_repository_impl.dart',
        'domain/entities/${shellFeature}_entity.dart',
        'application/providers/${shellFeature}_data_providers.dart',
        'application/providers/${shellFeature}_di_provider.dart',
        'application/services/${shellFeature}_service.dart',
        'presentation/providers/${shellFeature}_provider.dart',
        'presentation/screens/${shellFeature}_screen.dart',
      ]);

      await _expectFileContains(
        '${featureDir.path}/application/providers/${shellFeature}_data_providers.dart',
        [
          "import 'package:riverpod_annotation/riverpod_annotation.dart';",
          "part '${shellFeature}_data_providers.g.dart';",
          '@riverpod',
        ],
      );
      await _expectFileContains(
        '${featureDir.path}/application/providers/${shellFeature}_di_provider.dart',
        [
          "import 'package:riverpod_annotation/riverpod_annotation.dart';",
          "part '${shellFeature}_di_provider.g.dart';",
          '@riverpod',
        ],
      );
      await _expectFileContains(
        '${featureDir.path}/application/services/${shellFeature}_service.dart',
        [
          "part '${shellFeature}_service.g.dart';",
          'class ShellSmokeFeatureService',
        ],
      );
      await _expectFileContains(
        '${featureDir.path}/presentation/providers/${shellFeature}_provider.dart',
        [
          "part '${shellFeature}_provider.g.dart';",
          'extends _\$ShellSmokeFeature',
        ],
      );
    });

    test('dart generator creates clean-architecture riverpod files', () async {
      final tempDir = await Directory.systemTemp.createTemp('dart_generator_test_');
      addTearDown(() async {
        if (await tempDir.exists()) {
          await tempDir.delete(recursive: true);
        }
      });

      final result = await Process.run(
        'dart',
        ['run', dartGeneratorPath, dartFeature],
        workingDirectory: tempDir.path,
      );

      expect(result.exitCode, 0, reason: 'dart generator failed: ${result.stderr}');

      final featureDir = Directory('${tempDir.path}/lib/features/$dartFeature');
      expect(await featureDir.exists(), isTrue);

      await _expectFilesExist(featureDir.path, [
        'data/dtos/dtos.dart',
        'data/datasources/${dartFeature}_remote_data_source.dart',
        'application/providers/${dartFeature}_data_providers.dart',
        'application/providers/${dartFeature}_di_provider.dart',
        'application/services/${dartFeature}_service.dart',
        'presentation/providers/${dartFeature}_provider.dart',
      ]);

      await _expectFileContains(
        '${featureDir.path}/application/providers/${dartFeature}_data_providers.dart',
        [
          "import 'package:riverpod_annotation/riverpod_annotation.dart';",
          "part '${dartFeature}_data_providers.g.dart';",
          '@riverpod',
        ],
      );
      await _expectFileContains(
        '${featureDir.path}/application/providers/${dartFeature}_di_provider.dart',
        [
          "import 'package:riverpod_annotation/riverpod_annotation.dart';",
          "part '${dartFeature}_di_provider.g.dart';",
          '@riverpod',
        ],
      );
      await _expectFileContains(
        '${featureDir.path}/application/services/${dartFeature}_service.dart',
        [
          "part '${dartFeature}_service.g.dart';",
          'class DartSmokeFeatureService',
        ],
      );
      await _expectFileContains(
        '${featureDir.path}/presentation/providers/${dartFeature}_provider.dart',
        [
          "part '${dartFeature}_provider.g.dart';",
          'extends _\$DartSmokeFeature',
        ],
      );
    });
  });
}

Future<void> _expectFilesExist(String featureDir, List<String> relativePaths) async {
  for (final relativePath in relativePaths) {
    final file = File('$featureDir/$relativePath');
    expect(await file.exists(), isTrue, reason: 'missing file: $relativePath');
  }
}

Future<void> _expectFileContains(String path, List<String> expectedSnippets) async {
  final content = await File(path).readAsString();
  for (final snippet in expectedSnippets) {
    expect(content, contains(snippet), reason: 'missing snippet `$snippet` in $path');
  }
}
