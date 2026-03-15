// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_paging_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reportPaging)
const reportPagingProvider = ReportPagingProvider._();

final class ReportPagingProvider
    extends
        $FunctionalProvider<
          PagingController<int, ReportsEntity>,
          PagingController<int, ReportsEntity>,
          PagingController<int, ReportsEntity>
        >
    with $Provider<PagingController<int, ReportsEntity>> {
  const ReportPagingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportPagingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportPagingHash();

  @$internal
  @override
  $ProviderElement<PagingController<int, ReportsEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PagingController<int, ReportsEntity> create(Ref ref) {
    return reportPaging(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PagingController<int, ReportsEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PagingController<int, ReportsEntity>>(value),
    );
  }
}

String _$reportPagingHash() => r'c018d42183c93d834322ad0c20ff3ae358250eaf';
