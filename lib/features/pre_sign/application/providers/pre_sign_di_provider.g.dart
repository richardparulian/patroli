// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_sign_di_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(preSignCreateUseCase)
const preSignCreateUseCaseProvider = PreSignCreateUseCaseProvider._();

final class PreSignCreateUseCaseProvider
    extends
        $FunctionalProvider<
          PreSignCreateUseCase,
          PreSignCreateUseCase,
          PreSignCreateUseCase
        >
    with $Provider<PreSignCreateUseCase> {
  const PreSignCreateUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'preSignCreateUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$preSignCreateUseCaseHash();

  @$internal
  @override
  $ProviderElement<PreSignCreateUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PreSignCreateUseCase create(Ref ref) {
    return preSignCreateUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PreSignCreateUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PreSignCreateUseCase>(value),
    );
  }
}

String _$preSignCreateUseCaseHash() =>
    r'084236433a23442b8dba961f5f79e648f9e13af7';

@ProviderFor(preSignUpdateUseCase)
const preSignUpdateUseCaseProvider = PreSignUpdateUseCaseProvider._();

final class PreSignUpdateUseCaseProvider
    extends
        $FunctionalProvider<
          PreSignUpdateUseCase,
          PreSignUpdateUseCase,
          PreSignUpdateUseCase
        >
    with $Provider<PreSignUpdateUseCase> {
  const PreSignUpdateUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'preSignUpdateUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$preSignUpdateUseCaseHash();

  @$internal
  @override
  $ProviderElement<PreSignUpdateUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PreSignUpdateUseCase create(Ref ref) {
    return preSignUpdateUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PreSignUpdateUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PreSignUpdateUseCase>(value),
    );
  }
}

String _$preSignUpdateUseCaseHash() =>
    r'62cdcb64ca5e4a29f4fce1da4432d0938e6747c0';
