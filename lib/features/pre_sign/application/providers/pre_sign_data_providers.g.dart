// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_sign_data_providers.dart';

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

@ProviderFor(preSignRemoteDataSource)
const preSignRemoteDataSourceProvider = PreSignRemoteDataSourceProvider._();

final class PreSignRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          PreSignRemoteDataSource,
          PreSignRemoteDataSource,
          PreSignRemoteDataSource
        >
    with $Provider<PreSignRemoteDataSource> {
  const PreSignRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'preSignRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$preSignRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<PreSignRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PreSignRemoteDataSource create(Ref ref) {
    return preSignRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PreSignRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PreSignRemoteDataSource>(value),
    );
  }
}

String _$preSignRemoteDataSourceHash() =>
    r'a5be15172549f63d5de73654335b72e2bc5aa6a6';

@ProviderFor(preSignRepository)
const preSignRepositoryProvider = PreSignRepositoryProvider._();

final class PreSignRepositoryProvider
    extends
        $FunctionalProvider<
          PreSignRepository,
          PreSignRepository,
          PreSignRepository
        >
    with $Provider<PreSignRepository> {
  const PreSignRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'preSignRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$preSignRepositoryHash();

  @$internal
  @override
  $ProviderElement<PreSignRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PreSignRepository create(Ref ref) {
    return preSignRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PreSignRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PreSignRepository>(value),
    );
  }
}

String _$preSignRepositoryHash() => r'6d9dd36ebc3758bebf25272c47baa94c421fb293';
