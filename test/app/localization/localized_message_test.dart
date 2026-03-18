import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patroli/app/localization/localized_message.dart';
import 'package:patroli/l10n/app_localizations_delegate.dart';

void main() {
  group('localized_message', () {
    test('localizeMessage maps exact known message using active locale', () {
      final provider = Provider<String>(
        (ref) => localizeMessage(ref, 'QR Code tidak boleh kosong'),
      );

      final container = ProviderContainer(
        overrides: [
          defaultLocaleProvider.overrideWith((ref) => const Locale('id')),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(provider), 'QR Code tidak boleh kosong');
    });

    test('localizeMessage maps exact known English failure into Indonesian', () {
      final provider = Provider<String>(
        (ref) => localizeMessage(ref, 'No internet connection'),
      );

      final container = ProviderContainer(
        overrides: [
          defaultLocaleProvider.overrideWith((ref) => const Locale('id')),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(provider), 'Tidak ada koneksi internet');
    });

    test('localizeMessage maps prefix-based storage error', () {
      final provider = Provider<String>(
        (ref) => localizeMessage(ref, 'Failed to save data: boom'),
      );

      final container = ProviderContainer(
        overrides: [
          defaultLocaleProvider.overrideWith((ref) => const Locale('id')),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(provider), 'Gagal menyimpan data lokal');
    });

    test('localizeKey returns translated key value', () {
      final provider = Provider<String>(
        (ref) => localizeKey(ref, 'page_not_found'),
      );

      final container = ProviderContainer(
        overrides: [
          defaultLocaleProvider.overrideWith((ref) => const Locale('en')),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(provider), 'Page Not Found');
    });

    test('unknown message falls back to original text', () {
      const raw = 'Something custom from backend';
      final provider = Provider<String>(
        (ref) => localizeMessage(ref, raw),
      );

      final container = ProviderContainer(
        overrides: [
          defaultLocaleProvider.overrideWith((ref) => const Locale('id')),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(provider), raw);
    });
  });
}
