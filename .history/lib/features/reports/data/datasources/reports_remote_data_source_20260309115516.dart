import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/core/providers/network_providers.dart';
import '../models/reports_model.dart';

abstract class ReportsRemoteDataSource {
  // :: Fetch all reportss
  Future<List<ReportsModel>> fetchReports({required int page, required int limit});
  Future<int> countReports({required int status});
}

class ReportsRemoteDataSourceImpl implements ReportsRemoteDataSource {
  final ApiClient _apiClient;

  ReportsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<ReportsModel>> fetchReports({required int page, required int limit}) async {
    try {
      final result = await _apiClient.get(ApiEndpoints.visitList, queryParameters: {
        'page': page,
        'limit': limit,
      });

      return result.fold(
        (failure) => throw ServerException(message: failure.message),
        (response) => response.map((json) => ReportsModel.fromJson(json)).toList(),
      );
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<int> countReports({required int status}) async {
    try {
      final result = await _apiClient.get(ApiEndpoints.visitList, queryParameters: {
        'with_pagination': 0,
      });

      return result.fold(
        (failure) => throw ServerException(message: failure.message),
        (response) => response['data']['total'],
      );
    }on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}

// Provider
final reportsRemoteDataSourceProvider =Provider<ReportsRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ReportsRemoteDataSourceImpl(apiClient);
});

final apiClientProvider = Provider.autoDispose<ApiClient>((ref) {
  final dio = ref.watch(dioWithAuthProvider);
  return ApiClient(dio);
});
