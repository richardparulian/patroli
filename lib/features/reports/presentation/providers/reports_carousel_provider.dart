import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reports_carousel_provider.g.dart';

@riverpod
class ReportsCarousel extends _$ReportsCarousel {
  @override
  Map<int, int> build() {
    return const {};
  }

  void setIndex(int reportId, int index) {
    state = {
      ...state,
      reportId: index,
    };
  }

  void clearIndex(int reportId) {
    final updated = Map<int, int>.from(state);
    updated.remove(reportId);
    state = updated;
  }

  void clearAll() {
    state = const {};
  }
}
