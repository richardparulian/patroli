// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_sign_upload_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(preSignUploadService)
const preSignUploadServiceProvider = PreSignUploadServiceProvider._();

final class PreSignUploadServiceProvider
    extends
        $FunctionalProvider<
          PreSignUploadService,
          PreSignUploadService,
          PreSignUploadService
        >
    with $Provider<PreSignUploadService> {
  const PreSignUploadServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'preSignUploadServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$preSignUploadServiceHash();

  @$internal
  @override
  $ProviderElement<PreSignUploadService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PreSignUploadService create(Ref ref) {
    return preSignUploadService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PreSignUploadService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PreSignUploadService>(value),
    );
  }
}

String _$preSignUploadServiceHash() =>
    r'c797f23796f7c061087950a98fb33c8762328f7a';
