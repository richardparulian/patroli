import 'package:patroli/app/network/network_providers.dart';
import 'package:patroli/core/network/api_client.dart';
import 'package:patroli/core/providers/storage_providers.dart';
import 'package:patroli/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:patroli/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:patroli/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_data_providers.g.dart';

@riverpod
ApiClient apiClient(Ref ref) {
  final dio = ref.watch(dioWithAuthProvider);
  return ApiClient(dio);
}

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  final secureStorageService = ref.watch(secureStorageServiceProvider);
  return AuthRemoteDataSourceImpl(apiClient, secureStorageService);
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localStorageService = ref.watch(localStorageServiceProvider);
  final secureStorageService = ref.watch(secureStorageServiceProvider);

  return AuthRepositoryImpl(remoteDataSource, localStorageService, secureStorageService);
}
