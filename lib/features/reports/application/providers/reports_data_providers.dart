import 'package:patroli/app/network/network_providers.dart';
import 'package:patroli/core/network/api_client.dart';
import 'package:patroli/features/reports/data/datasources/reports_remote_data_source.dart';
import 'package:patroli/features/reports/data/repositories/reports_repository_impl.dart';
import 'package:patroli/features/reports/domain/repositories/reports_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reports_data_providers.g.dart';

@riverpod
ApiClient apiClient(Ref ref) {
  final dio = ref.watch(dioWithAuthProvider);
  return ApiClient(dio);
}

@riverpod
ReportsRemoteDataSource reportsRemoteDataSource(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ReportsRemoteDataSourceImpl(apiClient);
}

@riverpod
ReportsRepository reportsRepository(Ref ref) {
  final remoteDataSource = ref.watch(reportsRemoteDataSourceProvider);
  return ReportsRepositoryImpl(remoteDataSource);
}
