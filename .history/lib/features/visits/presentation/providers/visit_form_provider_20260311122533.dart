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

  VisitFormState copyWith({String? lampuBanner, String? bannerUtama, String? rollingDoor, Set<String>? rollingDoorChecklist}) {
    return VisitFormState(
      lampuBanner: lampuBanner ?? this.lampuBanner,
      bannerUtama: bannerUtama ?? this.bannerUtama,
      rollingDoor: rollingDoor ?? this.rollingDoor,
      rollingDoorChecklist: rollingDoorChecklist ?? this.rollingDoorChecklist,
      errors: errors,
    );
  }
}

class VisitFormNotifier extends Notifier<VisitFormState> {
  @override
  VisitFormState build() {
    return const VisitFormState();
  }

  void setLampuBanner(String value) {
    state = state.copyWith(lampuBanner: value);
  }

  void setBannerUtama(String value) {
    state = state.copyWith(bannerUtama: value);
  }

  void setRollingDoor(String value) {
    state = state.copyWith(rollingDoor: value);
  }

  void setRollingDoorChecklist(Set<String> value) {
    state = state.copyWith(rollingDoorChecklist: value);
  }
}

final visitFormProvider = NotifierProvider<VisitFormNotifier, VisitFormState>(VisitFormNotifier.new);