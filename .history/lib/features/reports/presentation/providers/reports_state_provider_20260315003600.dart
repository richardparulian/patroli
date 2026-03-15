import 'package:pos/features/reports/domain/entities/reports_entity.dart';

class ReportsState {
  final String? errorMessage;
  final List<ReportsEntity> reports; 
  final bool hasReachedMax;

  const ReportsState({
    this.errorMessage,
    this.reports = const [],
    this.hasReachedMax = false,
  });

  ReportsState copyWith({Object? errorMessage = _unset, List<ReportsEntity>? reports, bool? hasReachedMax}) {
    return ReportsState(
      errorMessage: identical(errorMessage, _unset) ? this.errorMessage : errorMessage as String?,
      reports: reports ?? this.reports,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

const _unset = Object();