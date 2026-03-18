// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_data_providers.dart';

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

@ProviderFor(reportsRepository)
const reportsRepositoryProvider = ReportsRepositoryProvider._();

final class ReportsRepositoryProvider
    extends
        $FunctionalProvider<
          ReportsRepository,
          ReportsRepository,
          ReportsRepository
        >
    with $Provider<ReportsRepository> {
  const ReportsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReportsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReportsRepository create(Ref ref) {
    return reportsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportsRepository>(value),
    );
  }
}

String _$reportsRepositoryHash() => r'de6f9475f358948d155605052aea249f2e98e7e8';
