import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/app/network/network_providers.dart';
import 'package:patroli/core/network/api_client.dart';
import 'package:patroli/features/visits/data/datasources/visit_remote_data_source.dart';
import 'package:patroli/features/visits/data/repositories/visit_repository_impl.dart';
import 'package:patroli/features/visits/domain/repositories/visit_repository.dart';

final visitApiClientProvider = Provider.autoDispose<ApiClient>((ref) {
  final dio = ref.watch(dioWithAuthProvider);
  return ApiClient(dio);
});

final visitRemoteDataSourceProvider = Provider<VisitRemoteDataSource>((ref) {
  final apiClient = ref.watch(visitApiClientProvider);
  return VisitRemoteDataSourceImpl(apiClient);
});

final visitRepositoryProvider = Provider<VisitRepository>((ref) {
  final remoteDataSource = ref.watch(visitRemoteDataSourceProvider);
  return VisitRepositoryImpl(remoteDataSource);
});
