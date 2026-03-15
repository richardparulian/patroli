// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_fetch_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReportsFetch)
const reportsFetchProvider = ReportsFetchProvider._();

final class ReportsFetchProvider
    extends $NotifierProvider<ReportsFetch, ReportsState> {
  const ReportsFetchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportsFetchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportsFetchHash();

  @$internal
  @override
  ReportsFetch create() => ReportsFetch();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportsState>(value),
    );
  }
}

String _$reportsFetchHash() => r'003633864d771328c3c114d7ed38523a796fbdcb';

abstract class _$ReportsFetch extends $Notifier<ReportsState> {
  ReportsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ReportsState, ReportsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReportsState, ReportsState>,
              ReportsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
