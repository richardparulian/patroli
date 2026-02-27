// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeRemoteDataSource)
const homeRemoteDataSourceProvider = HomeRemoteDataSourceProvider._();

final class HomeRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          HomeRemoteDataSource,
          HomeRemoteDataSource,
          HomeRemoteDataSource
        >
    with $Provider<HomeRemoteDataSource> {
  const HomeRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<HomeRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HomeRemoteDataSource create(Ref ref) {
    return homeRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeRemoteDataSource>(value),
    );
  }
}

String _$homeRemoteDataSourceHash() =>
    r'a1edf8c6a6b53fa2a74d41be18b8a584f8885840';
