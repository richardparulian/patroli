import 'package:patroli/app/network/network_providers.dart';
import 'package:patroli/core/network/api_client.dart';
import 'package:patroli/features/check_in/data/datasources/check_in_remote_data_source.dart';
import 'package:patroli/features/check_in/data/repositories/check_in_repository_impl.dart';
import 'package:patroli/features/check_in/domain/repositories/check_in_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'check_in_data_providers.g.dart';

@riverpod
ApiClient apiClient(Ref ref) {
  final dio = ref.watch(dioWithAuthProvider);
  return ApiClient(dio);
}

@riverpod
CheckInRemoteDataSource checkInRemoteDataSource(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CheckInRemoteDataSourceImpl(apiClient);
}

@riverpod
CheckInRepository checkInRepository(Ref ref) {
  final remoteDataSource = ref.watch(checkInRemoteDataSourceProvider);
  return CheckInRepositoryImpl(remoteDataSource);
}
