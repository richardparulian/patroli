import 'package:flutter_riverpod/flutter_riverpod.dart';

class VisitFormFields {
  static const lightsStatus = 'lightsStatus';
  static const bannerStatus = 'bannerStatus';
  static const rollingDoorStatus = 'rollingDoorStatus';
  static const rollingDoorChecklist = 'rollingDoorChecklist';
  static const conditionRight = 'conditionRight';
  static const conditionLeft = 'conditionLeft';
  static const conditionBack = 'conditionBack';
  static const conditionAround = 'conditionAround';
}

class VisitFormState {
  final String? lampuBanner;
  final String? bannerUtama;
  final String? rollingDoor;
  final Set<String> rollingDoorChecklist;
  final String? conditionRight;
  final String? conditionLeft;
  final String? conditionBack;
  final String? conditionAround;
  final Map<String, String> errorKeys;

  const VisitFormState({
    this.lampuBanner,
    this.bannerUtama,
    this.rollingDoor,
    this.rollingDoorChecklist = const {},
    this.conditionRight,
    this.conditionLeft,
    this.conditionBack,
    this.conditionAround,
    this.errorKeys = const {},
  });

  VisitFormState copyWith({
    String? lampuBanner,
    String? bannerUtama,
    String? rollingDoor,
    Set<String>? rollingDoorChecklist,
    String? conditionRight,
    String? conditionLeft,
    String? conditionBack,
    String? conditionAround,
    Map<String, String>? errorKeys,
  }) {
    return VisitFormState(
      lampuBanner: lampuBanner ?? this.lampuBanner,
      bannerUtama: bannerUtama ?? this.bannerUtama,
      rollingDoor: rollingDoor ?? this.rollingDoor,
      rollingDoorChecklist: rollingDoorChecklist ?? this.rollingDoorChecklist,
      conditionRight: conditionRight ?? this.conditionRight,
      conditionLeft: conditionLeft ?? this.conditionLeft,
      conditionBack: conditionBack ?? this.conditionBack,
      conditionAround: conditionAround ?? this.conditionAround,
      errorKeys: errorKeys ?? this.errorKeys,
    );
  }

  String? errorKeyFor(String field) => errorKeys[field];
}

class VisitFormNotifier extends Notifier<VisitFormState> {
  @override
  VisitFormState build() {
    return const VisitFormState();
  }

  bool validate() {
    final errorKeys = <String, String>{};

    if (state.lampuBanner == null || state.lampuBanner!.isEmpty) {
      errorKeys[VisitFormFields.lightsStatus] = 'visit_error_lights_required';
    }

    if (state.bannerUtama == null || state.bannerUtama!.isEmpty) {
      errorKeys[VisitFormFields.bannerStatus] = 'visit_error_banner_required';
    }

    if (state.rollingDoor == null || state.rollingDoor!.isEmpty) {
      errorKeys[VisitFormFields.rollingDoorStatus] =
          'visit_error_rolling_door_required';
    }

    if (state.rollingDoorChecklist.length != 2) {
      errorKeys[VisitFormFields.rollingDoorChecklist] =
          'visit_error_checklist_required';
    }

    if (state.conditionRight == null || state.conditionRight!.isEmpty) {
      errorKeys[VisitFormFields.conditionRight] = 'visit_error_right_required';
    }

    if (state.conditionLeft == null || state.conditionLeft!.isEmpty) {
      errorKeys[VisitFormFields.conditionLeft] = 'visit_error_left_required';
    }

    if (state.conditionBack == null || state.conditionBack!.isEmpty) {
      errorKeys[VisitFormFields.conditionBack] = 'visit_error_back_required';
    }

    if (state.conditionAround == null || state.conditionAround!.isEmpty) {
      errorKeys[VisitFormFields.conditionAround] =
          'visit_error_around_required';
    }

    state = state.copyWith(errorKeys: errorKeys);

    return errorKeys.isEmpty;
  }

  void setLampuBanner(String value) {
    state = state.copyWith(
      lampuBanner: value,
      errorKeys: {...state.errorKeys}..remove(VisitFormFields.lightsStatus),
    );
  }

  void setBannerUtama(String value) {
    state = state.copyWith(
      bannerUtama: value,
      errorKeys: {...state.errorKeys}..remove(VisitFormFields.bannerStatus),
    );
  }

  void setRollingDoor(String value) {
    state = state.copyWith(
      rollingDoor: value,
      errorKeys: {...state.errorKeys}
        ..remove(VisitFormFields.rollingDoorStatus),
    );
  }

  void setConditionRight(String value) {
    state = state.copyWith(
      conditionRight: value,
      errorKeys: {...state.errorKeys}..remove(VisitFormFields.conditionRight),
    );
  }

  void setConditionLeft(String value) {
    state = state.copyWith(
      conditionLeft: value,
      errorKeys: {...state.errorKeys}..remove(VisitFormFields.conditionLeft),
    );
  }

  void setConditionBack(String value) {
    state = state.copyWith(
      conditionBack: value,
      errorKeys: {...state.errorKeys}..remove(VisitFormFields.conditionBack),
    );
  }

  void setConditionAround(String value) {
    state = state.copyWith(
      conditionAround: value,
      errorKeys: {...state.errorKeys}..remove(VisitFormFields.conditionAround),
    );
  }

  void setRollingDoorChecklist(Set<String> values) {
    state = state.copyWith(
      rollingDoorChecklist: values,
      errorKeys: {...state.errorKeys}
        ..remove(VisitFormFields.rollingDoorChecklist),
    );
  }

  void setErrorKeys(Map<String, String> errorKeys) {
    if (!ref.mounted) return;

    state = state.copyWith(errorKeys: {...state.errorKeys, ...errorKeys});
  }

  void clearErrors() {
    state = state.copyWith(errorKeys: {});
  }

  void reset() {
    state = const VisitFormState();
  }
}

final visitFormProvider =
    NotifierProvider.autoDispose<VisitFormNotifier, VisitFormState>(
      VisitFormNotifier.new,
    );
