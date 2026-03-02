import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:pos/features/scan_qr/data/models/scan_qr_model.dart';

abstract class ScanQrRemoteDataSource {
  // :: Fetch all scan_qrs
  Future<List<ScanQrModel>> fetchScanQrs();
  Future<ScanQrModel> fetchScanQr(int id);
}

class ScanQrRemoteDataSourceImpl implements ScanQrRemoteDataSource {
  final ApiClient _apiClient;

  ScanQrRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<ScanQrModel>> fetchScanQrs() async {
    final result = await _apiClient.get('/scan_qrs');

    return result.fold(
      (failure) => throw Exception(failure.message),
      (response) {
        final List<dynamic> data = response;
        return data
            .map((json) => ScanQrModel.fromJson(json))
            .toList();
      },
    );
  }

  @override
  Future<ScanQrModel> fetchScanQr(int id) async {
    final result = await _apiClient.get('/scan_qrs/$id');

    return result.fold(
      (failure) => throw Exception(failure.message),
      (response) => ScanQrModel.fromJson(response),
    );
  }
}

// Provider
final scanQrRemoteDataSourceProvider =
    Provider<ScanQrRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ScanQrRemoteDataSourceImpl(apiClient);
});
