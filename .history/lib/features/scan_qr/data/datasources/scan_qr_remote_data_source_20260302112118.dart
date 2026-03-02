import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:pos/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import '../models/scan_qr_model.dart';

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
      (failure) => throw Exception(failure.message),
      (response) {
        return ScanQrModel.fromJson(response);
      },
    );
  }
}

// Provider
final scanQrRemoteDataSourceProvider = Provider<ScanQrRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ScanQrRemoteDataSourceImpl(apiClient);
});
