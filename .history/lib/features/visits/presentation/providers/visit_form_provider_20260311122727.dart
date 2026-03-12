import 'package:flutter_riverpod/flutter_riverpod.dart';

class VisitFormState {
  final String? lampuBanner;
  final String? bannerUtama;
  final String? rollingDoor;
  final Set<String> rollingDoorChecklist;
  final Map<String, String> errors;

  const VisitFormState({
    this.lampuBanner,
    this.bannerUtama,
    this.rollingDoor,
    this.rollingDoorChecklist = const {},
    this.errors = const {},
  });

  VisitFormState copyWith({String? lampuBanner, String? bannerUtama, String? rollingDoor, Set<String>? rollingDoorChecklist, Map<String, String>? errors}) {
    return VisitFormState(
      lampuBanner: lampuBanner ?? this.lampuBanner,
      bannerUtama: bannerUtama ?? this.bannerUtama,
      rollingDoor: rollingDoor ?? this.rollingDoor,
      rollingDoorChecklist: rollingDoorChecklist ?? this.rollingDoorChecklist,
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

  void setRollingDoorChecklist(Set<String> value) {
    state = state.copyWith(rollingDoorChecklist: value);
  }

  /// dipanggil dari API validation
  void setErrors(Map<String, String> errors) {
    state = state.copyWith(errors: errors);
  }

  /// clear semua error
  void clearErrors() {
    state = state.copyWith(errors: {});
  }
}

final visitFormProvider = NotifierProvider<VisitFormNotifier, VisitFormState>(VisitFormNotifier.new);