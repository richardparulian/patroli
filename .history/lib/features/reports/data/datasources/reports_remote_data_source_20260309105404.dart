import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/core/providers/network_providers.dart';
import '../models/reports_model.dart';

abstract class ReportsRemoteDataSource {
  // :: Fetch all reportss
  Future<List<ReportsModel>> fetchReportss();
  Future<ReportsModel> fetchReports(int id);
}

class ReportsRemoteDataSourceImpl implements ReportsRemoteDataSource {
  final ApiClient _apiClient;

  ReportsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<ReportsModel>> fetchReportss() async {
    final result = await _apiClient.get('/reportss');

    return result.fold(
      (failure) => throw Exception(failure.message),
      (response) {
        final List<dynamic> data = response;
        return data
            .map((json) => ReportsModel.fromJson(json))
            .toList();
      },
    );
  }

  @override
  Future<ReportsModel> fetchReports(int id) async {
    final result = await _apiClient.get('/reportss/$id');

    return result.fold(
      (failure) => throw Exception(failure.message),
      (response) => ReportsModel.fromJson(response),
    );
  }
}

// Provider
final reportsRemoteDataSourceProvider =
    Provider<ReportsRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ReportsRemoteDataSourceImpl(apiClient);
});
