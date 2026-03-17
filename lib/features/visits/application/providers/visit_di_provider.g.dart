// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_di_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(visitUseCase)
const visitUseCaseProvider = VisitUseCaseProvider._();

final class VisitUseCaseProvider
    extends
        $FunctionalProvider<
          CreateVisitUseCase,
          CreateVisitUseCase,
          CreateVisitUseCase
        >
    with $Provider<CreateVisitUseCase> {
  const VisitUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'visitUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$visitUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateVisitUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateVisitUseCase create(Ref ref) {
    return visitUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateVisitUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateVisitUseCase>(value),
    );
  }
}

String _$visitUseCaseHash() => r'2bd252fa9a88a9011e1ad36b60773be5be0e460c';
