// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_carousel_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReportsCarousel)
const reportsCarouselProvider = ReportsCarouselProvider._();

final class ReportsCarouselProvider
    extends $NotifierProvider<ReportsCarousel, Map<int, int>> {
  const ReportsCarouselProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportsCarouselProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportsCarouselHash();

  @$internal
  @override
  ReportsCarousel create() => ReportsCarousel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<int, int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<int, int>>(value),
    );
  }
}

String _$reportsCarouselHash() => r'4b05073ecc68a1b0fc1351e25341b1c780580d11';

abstract class _$ReportsCarousel extends $Notifier<Map<int, int>> {
  Map<int, int> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<int, int>, Map<int, int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<int, int>, Map<int, int>>,
              Map<int, int>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
