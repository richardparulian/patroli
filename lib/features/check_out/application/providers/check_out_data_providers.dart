import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/app/network/network_providers.dart';
import 'package:patroli/core/network/api_client.dart';
import 'package:patroli/features/check_out/data/datasources/check_out_remote_data_source.dart';
import 'package:patroli/features/check_out/data/repositories/check_out_repository_impl.dart';
import 'package:patroli/features/check_out/domain/repositories/check_out_repository.dart';

final checkOutApiClientProvider = Provider.autoDispose<ApiClient>((ref) {
  final dio = ref.watch(dioWithAuthProvider);
  return ApiClient(dio);
});

final checkOutRemoteDataSourceProvider = Provider<CheckOutRemoteDataSource>((ref) {
  final apiClient = ref.watch(checkOutApiClientProvider);
  return CheckOutRemoteDataSourceImpl(apiClient);
});

final checkOutRepositoryProvider = Provider<CheckOutRepository>((ref) {
  final remoteDataSource = ref.watch(checkOutRemoteDataSourceProvider);
  return CheckOutRepositoryImpl(remoteDataSource);
});
