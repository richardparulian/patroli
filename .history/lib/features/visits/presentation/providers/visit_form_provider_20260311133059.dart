import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  void setconditionAround(String value) {
    state = state.copyWith(conditionAround: value, errors: {...state.errors}..remove('conditionAround'));
  }

 bool validate() {
    final errors = {...state.errors};

    // reset error yang akan divalidasi ulang
    errors.remove('rollingDoorChecklist');

    if (state.rollingDoorChecklist.length != 2) {
      errors['rollingDoorChecklist'] = 'Semua checklist harus dicentang';
    }

    state = state.copyWith(errors: errors);

    return errors.isEmpty;
  }

  void setRollingDoorChecklist(Set<String> values) {
    state = state.copyWith(
      rollingDoorChecklist: values,
      errors: {...state.errors}..remove('rollingDoorChecklist'),
    );
  }

  // dipanggil dari API validation
  void setErrors(Map<String, String> errors) {
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

final visitFormProvider = NotifierProvider<VisitFormNotifier, VisitFormState>(VisitFormNotifier.new);