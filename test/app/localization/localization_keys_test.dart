import 'package:flutter_test/flutter_test.dart';
import 'package:patroli/l10n/l10n.dart';

void main() {
  group('localization key conventions', () {
    const snakeCasePattern = r'^[a-z0-9]+(?:_[a-z0-9]+)*$';
    final regex = RegExp(snakeCasePattern);

    test('custom English localization keys use snake_case', () {
      final keys = localizedValues['en']!.keys;
      final invalidKeys = keys.where((key) => !regex.hasMatch(key)).toList();

      expect(invalidKeys, isEmpty, reason: 'Invalid keys: ${invalidKeys.join(', ')}');
    });

    test('custom Indonesian localization keys use snake_case', () {
      final keys = localizedValues['id']!.keys;
      final invalidKeys = keys.where((key) => !regex.hasMatch(key)).toList();

      expect(invalidKeys, isEmpty, reason: 'Invalid keys: ${invalidKeys.join(', ')}');
    });

    test('custom English and Indonesian localization maps stay aligned', () {
      final enKeys = localizedValues['en']!.keys.toSet();
      final idKeys = localizedValues['id']!.keys.toSet();

      expect(idKeys.difference(enKeys), isEmpty, reason: 'Extra id keys: ${idKeys.difference(enKeys).join(', ')}');
      expect(enKeys.difference(idKeys), isEmpty, reason: 'Missing id keys: ${enKeys.difference(idKeys).join(', ')}');
    });
  });
}
