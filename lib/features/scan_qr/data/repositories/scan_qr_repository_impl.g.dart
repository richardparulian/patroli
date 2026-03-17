// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_qr_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
