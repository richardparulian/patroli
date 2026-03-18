// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_qr_data_providers.dart';

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

@ProviderFor(scanQrRemoteDataSource)
const scanQrRemoteDataSourceProvider = ScanQrRemoteDataSourceProvider._();

final class ScanQrRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          ScanQrRemoteDataSource,
          ScanQrRemoteDataSource,
          ScanQrRemoteDataSource
        >
    with $Provider<ScanQrRemoteDataSource> {
  const ScanQrRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scanQrRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scanQrRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<ScanQrRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ScanQrRemoteDataSource create(Ref ref) {
    return scanQrRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScanQrRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScanQrRemoteDataSource>(value),
    );
  }
}

String _$scanQrRemoteDataSourceHash() =>
    r'faa6cab849ae595b5c824e91ecddba6921b9a033';

@ProviderFor(scanQrRepository)
const scanQrRepositoryProvider = ScanQrRepositoryProvider._();

final class ScanQrRepositoryProvider
    extends
        $FunctionalProvider<
          ScanQrRepository,
          ScanQrRepository,
          ScanQrRepository
        >
    with $Provider<ScanQrRepository> {
  const ScanQrRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scanQrRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scanQrRepositoryHash();

  @$internal
  @override
  $ProviderElement<ScanQrRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ScanQrRepository create(Ref ref) {
    return scanQrRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScanQrRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScanQrRepository>(value),
    );
  }
}

String _$scanQrRepositoryHash() => r'ab28902953f8abd7d2783a24f3799b82635279bd';
