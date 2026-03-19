import 'package:patroli/core/error/exceptions.dart';
import 'package:patroli/core/network/api_client.dart';
import 'package:patroli/core/network/api_endpoints.dart';
import 'package:patroli/features/reports/data/dtos/response/reports_response.dart';
import '../models/reports_model.dart';

abstract class ReportsRemoteDataSource {
  // :: Fetch all reportss
  Future<List<ReportsModel>> fetchReports({
    int? page,
    int? limit,
    int? pagination,
  });
}

class ReportsRemoteDataSourceImpl implements ReportsRemoteDataSource {
  final ApiClient _apiClient;

  ReportsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<ReportsModel>> fetchReports({
    int? page,
    int? limit,
    int? pagination,
  }) async {
    final result = await _apiClient.get(
      ApiEndpoints.visitList,
      queryParameters: {
        'page': page,
        'per_page': limit,
        'with_pagination': pagination,
      },
    );

    return result.fold((failure) => throw exceptionFromFailure(failure), (
      response,
    ) {
      final reportsResponse = ReportsResponse.fromJson(response);
      return reportsResponse.data;
    });
  }
}
