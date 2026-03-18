// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_data_providers.dart';

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

@ProviderFor(checkInRemoteDataSource)
const checkInRemoteDataSourceProvider = CheckInRemoteDataSourceProvider._();

final class CheckInRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          CheckInRemoteDataSource,
          CheckInRemoteDataSource,
          CheckInRemoteDataSource
        >
    with $Provider<CheckInRemoteDataSource> {
  const CheckInRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkInRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkInRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<CheckInRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CheckInRemoteDataSource create(Ref ref) {
    return checkInRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CheckInRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CheckInRemoteDataSource>(value),
    );
  }
}

String _$checkInRemoteDataSourceHash() =>
    r'd0b7da68a75aec57675c461ae480100e496ef676';

@ProviderFor(checkInRepository)
const checkInRepositoryProvider = CheckInRepositoryProvider._();

final class CheckInRepositoryProvider
    extends
        $FunctionalProvider<
          CheckInRepository,
          CheckInRepository,
          CheckInRepository
        >
    with $Provider<CheckInRepository> {
  const CheckInRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkInRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkInRepositoryHash();

  @$internal
  @override
  $ProviderElement<CheckInRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CheckInRepository create(Ref ref) {
    return checkInRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CheckInRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CheckInRepository>(value),
    );
  }
}

String _$checkInRepositoryHash() => r'3ee315cb5c369496d8ce0d37b173a3e38533bbe4';
