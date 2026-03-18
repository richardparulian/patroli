import 'package:patroli/app/network/network_providers.dart';
import 'package:patroli/core/network/api_client.dart';
import 'package:patroli/features/pre_sign/data/datasources/pre_sign_remote_data_source.dart';
import 'package:patroli/features/pre_sign/data/repositories/pre_sign_repository_impl.dart';
import 'package:patroli/features/pre_sign/domain/repositories/pre_sign_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pre_sign_data_providers.g.dart';

@riverpod
ApiClient apiClient(Ref ref) {
  final dio = ref.watch(dioWithAuthProvider);
  return ApiClient(dio);
}

@riverpod
PreSignRemoteDataSource preSignRemoteDataSource(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return PreSignRemoteDataSourceImpl(apiClient);
}

@riverpod
PreSignRepository preSignRepository(Ref ref) {
  final remoteDataSource = ref.watch(preSignRemoteDataSourceProvider);
  return PreSignRepositoryImpl(remoteDataSource);
}
