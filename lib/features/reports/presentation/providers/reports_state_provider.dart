import 'package:pos/features/reports/domain/entities/reports_entity.dart';

class ReportsState {
  final int countByStatus;
  final int totalReports;
  final String? errorMessage;
  final List<ReportsEntity> reports; 
  final bool hasReachedMax;
  final Map<int, int> carouselIndexes;

  const ReportsState({
    this.countByStatus = 0,
    this.totalReports = 0,
    this.errorMessage,
    this.reports = const [],
    this.hasReachedMax = false,
    this.carouselIndexes = const {},
  });

  ReportsState copyWith({
    int? countByStatus,
    int? totalReports,
    String? errorMessage, 
    List<ReportsEntity>? reports,
    bool? hasReachedMax,
    Map<int, int>? carouselIndexes,
  }) {
    return ReportsState(
      countByStatus: countByStatus ?? this.countByStatus,
      totalReports: totalReports ?? this.totalReports,
      errorMessage: errorMessage,
      reports: reports ?? this.reports,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      carouselIndexes: carouselIndexes ?? this.carouselIndexes,
    );
  }
}