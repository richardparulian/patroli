// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_qr_di_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scanQrUseCase)
const scanQrUseCaseProvider = ScanQrUseCaseProvider._();

final class ScanQrUseCaseProvider
    extends $FunctionalProvider<ScanQrUseCase, ScanQrUseCase, ScanQrUseCase>
    with $Provider<ScanQrUseCase> {
  const ScanQrUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scanQrUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scanQrUseCaseHash();

  @$internal
  @override
  $ProviderElement<ScanQrUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ScanQrUseCase create(Ref ref) {
    return scanQrUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScanQrUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScanQrUseCase>(value),
    );
  }
}

String _$scanQrUseCaseHash() => r'9045720789f3802ba31d255c5ebbace871ba6bd9';
