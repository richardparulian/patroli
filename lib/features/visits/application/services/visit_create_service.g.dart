// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_create_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(visitCreateService)
const visitCreateServiceProvider = VisitCreateServiceProvider._();

final class VisitCreateServiceProvider
    extends
        $FunctionalProvider<
          VisitCreateService,
          VisitCreateService,
          VisitCreateService
        >
    with $Provider<VisitCreateService> {
  const VisitCreateServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'visitCreateServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$visitCreateServiceHash();

  @$internal
  @override
  $ProviderElement<VisitCreateService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VisitCreateService create(Ref ref) {
    return visitCreateService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VisitCreateService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VisitCreateService>(value),
    );
  }
}

String _$visitCreateServiceHash() =>
    r'8027297f9ce149928759c506989f0635a47a0409';
