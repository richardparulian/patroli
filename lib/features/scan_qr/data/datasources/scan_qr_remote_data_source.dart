import 'package:patroli/core/error/exceptions.dart';
import 'package:patroli/core/network/api_client.dart';
import 'package:patroli/core/network/api_endpoints.dart';
import 'package:patroli/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import 'package:patroli/features/scan_qr/data/dtos/response/scan_qr_response.dart';
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
      (failure) => throw ServerException(message: failure.message),
      (response) => ScanQrResponse.fromJson(response).data,
    );
  }
}
