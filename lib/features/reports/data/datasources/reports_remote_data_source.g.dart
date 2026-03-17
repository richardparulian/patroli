// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(apiClient)
const apiClientProvider = ApiClientProvider._();

final class ApiClientProvider
    extends $FunctionalProvider<ApiClient, ApiClient, ApiClient>
    with $Provider<ApiClient> {
  const ApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiClientHash();

  @$internal
  @override
  $ProviderElement<ApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiClient create(Ref ref) {
    return apiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiClient>(value),
    );
  }
}

String _$apiClientHash() => r'81e532f9b40750f0efef8945eaceb4ff566c8d4d';

@ProviderFor(reportsRemoteDataSource)
const reportsRemoteDataSourceProvider = ReportsRemoteDataSourceProvider._();

final class ReportsRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          ReportsRemoteDataSource,
          ReportsRemoteDataSource,
          ReportsRemoteDataSource
        >
    with $Provider<ReportsRemoteDataSource> {
  const ReportsRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportsRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportsRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<ReportsRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReportsRemoteDataSource create(Ref ref) {
    return reportsRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportsRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportsRemoteDataSource>(value),
    );
  }
}

String _$reportsRemoteDataSourceHash() =>
    r'92fed4ad34154c8bd4a7193430c7efefbb4c23fd';
