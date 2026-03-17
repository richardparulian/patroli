// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_out_di_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(checkOutUseCase)
const checkOutUseCaseProvider = CheckOutUseCaseProvider._();

final class CheckOutUseCaseProvider
    extends
        $FunctionalProvider<
          CreateCheckOutUseCase,
          CreateCheckOutUseCase,
          CreateCheckOutUseCase
        >
    with $Provider<CreateCheckOutUseCase> {
  const CheckOutUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkOutUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkOutUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateCheckOutUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateCheckOutUseCase create(Ref ref) {
    return checkOutUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateCheckOutUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateCheckOutUseCase>(value),
    );
  }
}

String _$checkOutUseCaseHash() => r'24583bf9e0442fd318a73df60acbaf1786e03b72';
