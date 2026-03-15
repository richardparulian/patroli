import 'package:pos/features/reports/domain/entities/reports_entity.dart';

class ReportsState {
  final String? errorMessage;
  final List<ReportsEntity> reports; 
  final bool hasReachedMax;
  final Map<int, int> carouselIndexes;

  const ReportsState({
    this.errorMessage,
    this.reports = const [],
    this.hasReachedMax = false,
    this.carouselIndexes = const {},
  });

  ReportsState copyWith({Object? errorMessage = _unset, List<ReportsEntity>? reports, bool? hasReachedMax, Map<int, int>? carouselIndexes}) {
    return ReportsState(
      errorMessage: identical(errorMessage, _unset) ? this.errorMessage : errorMessage as String?,
      reports: reports ?? this.reports,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      carouselIndexes: carouselIndexes ?? this.carouselIndexes,
    );
  }
}

const _unset = Object();