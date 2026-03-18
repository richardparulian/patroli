import 'package:patroli/app/network/network_providers.dart';
import 'package:patroli/core/network/api_client.dart';
import 'package:patroli/features/scan_qr/data/datasources/scan_qr_remote_data_source.dart';
import 'package:patroli/features/scan_qr/data/repositories/scan_qr_repository_impl.dart';
import 'package:patroli/features/scan_qr/domain/repositories/scan_qr_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scan_qr_data_providers.g.dart';

@riverpod
ApiClient apiClient(Ref ref) {
  final dio = ref.watch(dioWithAuthProvider);
  return ApiClient(dio);
}

@riverpod
ScanQrRemoteDataSource scanQrRemoteDataSource(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ScanQrRemoteDataSourceImpl(apiClient);
}

@riverpod
ScanQrRepository scanQrRepository(Ref ref) {
  final remoteDataSource = ref.watch(scanQrRemoteDataSourceProvider);
  return ScanQrRepositoryImpl(remoteDataSource);
}
