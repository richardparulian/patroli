// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_refresh_coordinator_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reportsRefreshCoordinator)
const reportsRefreshCoordinatorProvider = ReportsRefreshCoordinatorProvider._();

final class ReportsRefreshCoordinatorProvider
    extends
        $FunctionalProvider<
          ReportsRefreshCoordinator,
          ReportsRefreshCoordinator,
          ReportsRefreshCoordinator
        >
    with $Provider<ReportsRefreshCoordinator> {
  const ReportsRefreshCoordinatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportsRefreshCoordinatorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportsRefreshCoordinatorHash();

  @$internal
  @override
  $ProviderElement<ReportsRefreshCoordinator> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReportsRefreshCoordinator create(Ref ref) {
    return reportsRefreshCoordinator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportsRefreshCoordinator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportsRefreshCoordinator>(value),
    );
  }
}

String _$reportsRefreshCoordinatorHash() =>
    r'c33534c087cc15e41c7f54d0192be264cd9704ea';
