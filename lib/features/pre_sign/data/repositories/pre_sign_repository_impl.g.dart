// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_sign_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
