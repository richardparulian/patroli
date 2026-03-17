// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_fetch_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reportsFetchService)
const reportsFetchServiceProvider = ReportsFetchServiceProvider._();

final class ReportsFetchServiceProvider
    extends
        $FunctionalProvider<
          ReportsFetchService,
          ReportsFetchService,
          ReportsFetchService
        >
    with $Provider<ReportsFetchService> {
  const ReportsFetchServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportsFetchServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportsFetchServiceHash();

  @$internal
  @override
  $ProviderElement<ReportsFetchService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReportsFetchService create(Ref ref) {
    return reportsFetchService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportsFetchService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportsFetchService>(value),
    );
  }
}

String _$reportsFetchServiceHash() =>
    r'9caf8d95a8c2db0ec47bef34bb79f48e4ec65bfa';
