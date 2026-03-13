import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/core/providers/network_providers.dart';
import 'package:pos/features/reports/data/dtos/response/reports_response.dart';
import '../models/reports_model.dart';

abstract class ReportsRemoteDataSource {
  // :: Fetch all reportss
  Future<List<ReportsModel>> fetchReports({int? page, int? limit, int? pagination});
}

class ReportsRemoteDataSourceImpl implements ReportsRemoteDataSource {
  final ApiClient _apiClient;

  ReportsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<ReportsModel>> fetchReports({int? page, int? limit, int? pagination}) async {
    try {
      final result = await _apiClient.get(ApiEndpoints.visitList, queryParameters: {
        'page': page,
        'per_page': limit,
        'with_pagination': pagination,
      });

      return result.fold(
        (failure) => throw ServerException(message: failure.message),
        (response) {
          final reportsResponse = ReportsResponse.fromJson(response);
          return reportsResponse.data;
        },
      );
    } on ServerException {
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
