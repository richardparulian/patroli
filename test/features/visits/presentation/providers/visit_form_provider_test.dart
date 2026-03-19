import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patroli/features/visits/presentation/providers/visit_form_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  test('validate stores localization keys instead of localized messages', () {
    final notifier = container.read(visitFormProvider.notifier);

    final isValid = notifier.validate();
    final state = container.read(visitFormProvider);

    expect(isValid, isFalse);
    expect(
      state.errorKeyFor(VisitFormFields.lightsStatus),
      'visit_error_lights_required',
    );
    expect(
      state.errorKeyFor(VisitFormFields.bannerStatus),
      'visit_error_banner_required',
    );
  });

  test('setLampuBanner clears only its own validation key', () {
    final notifier = container.read(visitFormProvider.notifier);

    notifier.validate();
    notifier.setLampuBanner('On');

    final state = container.read(visitFormProvider);

    expect(state.errorKeyFor(VisitFormFields.lightsStatus), isNull);
    expect(
      state.errorKeyFor(VisitFormFields.bannerStatus),
      'visit_error_banner_required',
    );
  });
}
