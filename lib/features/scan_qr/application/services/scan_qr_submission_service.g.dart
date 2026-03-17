// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_qr_submission_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scanQrSubmissionService)
const scanQrSubmissionServiceProvider = ScanQrSubmissionServiceProvider._();

final class ScanQrSubmissionServiceProvider
    extends
        $FunctionalProvider<
          ScanQrSubmissionService,
          ScanQrSubmissionService,
          ScanQrSubmissionService
        >
    with $Provider<ScanQrSubmissionService> {
  const ScanQrSubmissionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scanQrSubmissionServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scanQrSubmissionServiceHash();

  @$internal
  @override
  $ProviderElement<ScanQrSubmissionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ScanQrSubmissionService create(Ref ref) {
    return scanQrSubmissionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScanQrSubmissionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScanQrSubmissionService>(value),
    );
  }
}

String _$scanQrSubmissionServiceHash() =>
    r'522c2cfda715b7914c9dba4cf05ab1ea1d0261c0';
