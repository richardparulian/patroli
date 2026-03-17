// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_di_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(checkInUseCase)
const checkInUseCaseProvider = CheckInUseCaseProvider._();

final class CheckInUseCaseProvider
    extends
        $FunctionalProvider<
          CreateCheckInUseCase,
          CreateCheckInUseCase,
          CreateCheckInUseCase
        >
    with $Provider<CreateCheckInUseCase> {
  const CheckInUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkInUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkInUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateCheckInUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateCheckInUseCase create(Ref ref) {
    return checkInUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateCheckInUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateCheckInUseCase>(value),
    );
  }
}

String _$checkInUseCaseHash() => r'05708d395a60f576dcd68f8979db5db780e1afe6';
