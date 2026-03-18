// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_count_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CountReports)
const countReportsProvider = CountReportsProvider._();

final class CountReportsProvider
    extends $NotifierProvider<CountReports, ResultState<ReportsCount>> {
  const CountReportsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'countReportsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$countReportsHash();

  @$internal
  @override
  CountReports create() => CountReports();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResultState<ReportsCount> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResultState<ReportsCount>>(value),
    );
  }
}

String _$countReportsHash() => r'dbc37a4f76f2738c8285b2e8faaba63f1a4bc58f';

abstract class _$CountReports extends $Notifier<ResultState<ReportsCount>> {
  ResultState<ReportsCount> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<ResultState<ReportsCount>, ResultState<ReportsCount>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ResultState<ReportsCount>, ResultState<ReportsCount>>,
              ResultState<ReportsCount>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
