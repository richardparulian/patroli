import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/core/providers/network_providers.dart';
import 'package:pos/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import 'package:pos/features/scan_qr/data/dtos/response/scan_qr_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/scan_qr_model.dart';

part 'scan_qr_remote_data_source.g.dart';

abstract class ScanQrRemoteDataSource {
  // :: Create a new scan_qr
  Future<ScanQrModel> createScanQr(ScanQrRequest request);
}

class ScanQrRemoteDataSourceImpl implements ScanQrRemoteDataSource {
  final ApiClient _apiClient;

  ScanQrRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ScanQrModel> createScanQr(ScanQrRequest request) async {
    final result = await _apiClient.post(ApiEndpoints.scanQr, data: request.toJson());

    return result.fold(
      (failure) => throw ServerException(message: failure.message),
      (response) => ScanQrResponse.fromJson(response).data,
    );
  }
}

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
