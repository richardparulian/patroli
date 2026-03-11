import 'package:pos/features/reports/domain/entities/reports_entity.dart';

class ReportsState {
  final List<ReportsEntity> reports;
  final Map<int, int> carouselIndexes;
  final bool hasReachedMax;
  final int countByStatus;
  final int totalReports;

  const ReportsState({
    this.reports = const [],
    this.carouselIndexes = const {},
    this.hasReachedMax = false,
    this.countByStatus = 0,
    this.totalReports = 0,
  });

  ReportsState copyWith({
    List<ReportsEntity>? reports,
    Map<int, int>? carouselIndexes,
    bool? hasReachedMax,
    int? countByStatus,
    int? totalReports,
  }) {
    return ReportsState(
      reports: reports ?? this.reports,
      carouselIndexes: carouselIndexes ?? this.carouselIndexes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      countByStatus: countByStatus ?? this.countByStatus,
      totalReports: totalReports ?? this.totalReports,
    );
  }
}