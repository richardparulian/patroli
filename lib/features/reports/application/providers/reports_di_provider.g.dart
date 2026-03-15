// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_di_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reportsUseCase)
const reportsUseCaseProvider = ReportsUseCaseProvider._();

final class ReportsUseCaseProvider
    extends $FunctionalProvider<ReportsUseCase, ReportsUseCase, ReportsUseCase>
    with $Provider<ReportsUseCase> {
  const ReportsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportsUseCaseHash();

  @$internal
  @override
  $ProviderElement<ReportsUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReportsUseCase create(Ref ref) {
    return reportsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportsUseCase>(value),
    );
  }
}

String _$reportsUseCaseHash() => r'9691806628d418c50281af473e5c97bda05b702a';
