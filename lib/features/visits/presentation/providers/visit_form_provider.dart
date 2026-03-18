import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/app/localization/localization_providers.dart';
import 'package:patroli/l10n/l10n.dart';

class VisitFormState {
  final String? lampuBanner;
  final String? bannerUtama;
  final String? rollingDoor;
  final Set<String> rollingDoorChecklist;
  final String? conditionRight;
  final String? conditionLeft;
  final String? conditionBack;
  final String? conditionAround;
  final Map<String, String> errors;

  const VisitFormState({
    this.lampuBanner,
    this.bannerUtama,
    this.rollingDoor,
    this.rollingDoorChecklist = const {},
    this.conditionRight,
    this.conditionLeft,
    this.conditionBack,
    this.conditionAround,
    this.errors = const {},
  });

  VisitFormState copyWith({String? lampuBanner, String? bannerUtama, String? rollingDoor, Set<String>? rollingDoorChecklist, String? conditionRight, String? conditionLeft, String? conditionBack, String? conditionAround, Map<String, String>? errors}) {
    return VisitFormState(
      lampuBanner: lampuBanner ?? this.lampuBanner,
      bannerUtama: bannerUtama ?? this.bannerUtama,
      rollingDoor: rollingDoor ?? this.rollingDoor,
      rollingDoorChecklist: rollingDoorChecklist ?? this.rollingDoorChecklist,
      conditionRight: conditionRight ?? this.conditionRight,
      conditionLeft: conditionLeft ?? this.conditionLeft,
      conditionBack: conditionBack ?? this.conditionBack,
      conditionAround: conditionAround ?? this.conditionAround,
      errors: errors ?? this.errors,
    );
  }
}

class VisitFormNotifier extends Notifier<VisitFormState> {
  @override
  VisitFormState build() {
    return const VisitFormState();
  }

  bool validate() {
    final locale = ref.read(persistentLocaleProvider);
    final translations = localizedValues[locale.languageCode] ?? localizedValues['en'] ?? {};
    String tr(String key) => translations[key] ?? localizedValues['en']?[key] ?? key;

    final errors = <String, String>{};

    if (state.lampuBanner == null || state.lampuBanner!.isEmpty) {
      errors['lightsStatus'] = tr('visit_error_lights_required');
    }

    if (state.bannerUtama == null || state.bannerUtama!.isEmpty) {
      errors['bannerStatus'] = tr('visit_error_banner_required');
    }

    if (state.rollingDoor == null || state.rollingDoor!.isEmpty) {
      errors['rollingDoorStatus'] = tr('visit_error_rolling_door_required');
    }

    if (state.rollingDoorChecklist.length != 2) {
      errors['rollingDoorChecklist'] = tr('visit_error_checklist_required');
    }

    if (state.conditionRight == null || state.conditionRight!.isEmpty) {
      errors['conditionRight'] = tr('visit_error_right_required');
    }

    if (state.conditionLeft == null || state.conditionLeft!.isEmpty) {
      errors['conditionLeft'] = tr('visit_error_left_required');
    }

    if (state.conditionBack == null || state.conditionBack!.isEmpty) {
      errors['conditionBack'] = tr('visit_error_back_required');
    }

    if (state.conditionAround == null || state.conditionAround!.isEmpty) {
      errors['conditionAround'] = tr('visit_error_around_required');
    }

    state = state.copyWith(errors: errors);

    return errors.isEmpty;
  }

  void setLampuBanner(String value) {
    state = state.copyWith(
      lampuBanner: value,
      errors: {...state.errors}..remove('lightsStatus'),
    );
  }

  void setBannerUtama(String value) {
    state = state.copyWith(
      bannerUtama: value,
      errors: {...state.errors}..remove('bannerStatus'),
    );
  }

  void setRollingDoor(String value) {
    state = state.copyWith(
      rollingDoor: value,
      errors: {...state.errors}..remove('rollingDoorStatus'),
    );
  }

  void setConditionRight(String value) {
    state = state.copyWith(conditionRight: value, errors: {...state.errors}..remove('conditionRight'));
  }

  void setConditionLeft(String value) {
    state = state.copyWith(conditionLeft: value, errors: {...state.errors}..remove('conditionLeft'));
  }

  void setConditionBack(String value) {
    state = state.copyWith(conditionBack: value, errors: {...state.errors}..remove('conditionBack'));
  }

  void setConditionAround(String value) {
    state = state.copyWith(conditionAround: value, errors: {...state.errors}..remove('conditionAround'));
  }

  void setRollingDoorChecklist(Set<String> values) {
    state = state.copyWith(
      rollingDoorChecklist: values,
      errors: {...state.errors}..remove('rollingDoorChecklist'),
    );
  }

  // dipanggil dari API validation
  void setErrors(Map<String, String> errors) {
    if (!ref.mounted) return;

    state = state.copyWith(
      errors: {
        ...state.errors,
        ...errors,
      },
    );
  }

  // clear semua error
  void clearErrors() {
    state = state.copyWith(errors: {});
  }

  void reset() {
    state = const VisitFormState();
  }
}

final visitFormProvider = NotifierProvider.autoDispose<VisitFormNotifier, VisitFormState>(VisitFormNotifier.new);