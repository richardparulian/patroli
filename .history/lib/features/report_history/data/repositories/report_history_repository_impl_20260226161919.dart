import 'package:pos/features/report_history/data/datasources/report_history_remote_data_source.dart';
import 'package:pos/features/report_history/domain/entities/report_history_entity.dart';
import 'package:pos/features/report_history/domain/repositories/report_history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_history_repository_impl.g.dart';

@riverpod
ReportHistoryRepository reportHistoryRepository(Ref ref) {
  final remoteDataSource = ref.watch(reportHistoryRemoteDataSourceProvider);
  return ReportHistoryRepositoryImpl(remoteDataSource);
}

class ReportHistoryRepositoryImpl implements ReportHistoryRepository {
  final ReportHistoryRemoteDataSource _remoteDataSource;

  ReportHistoryRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<ReportHistoryEntity>> getReportHistorys() async {
    final models = await _remoteDataSource.fetchReportHistorys();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<ReportHistoryEntity> getReportHistory(String id) async {
    final model = await _remoteDataSource.fetchReportHistory(id);
    return model.toEntity();
  }
}
