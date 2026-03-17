// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_out_submission_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(checkOutSubmissionService)
const checkOutSubmissionServiceProvider = CheckOutSubmissionServiceProvider._();

final class CheckOutSubmissionServiceProvider
    extends
        $FunctionalProvider<
          CheckOutSubmissionService,
          CheckOutSubmissionService,
          CheckOutSubmissionService
        >
    with $Provider<CheckOutSubmissionService> {
  const CheckOutSubmissionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkOutSubmissionServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkOutSubmissionServiceHash();

  @$internal
  @override
  $ProviderElement<CheckOutSubmissionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CheckOutSubmissionService create(Ref ref) {
    return checkOutSubmissionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CheckOutSubmissionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CheckOutSubmissionService>(value),
    );
  }
}

String _$checkOutSubmissionServiceHash() =>
    r'a3460ae8ae0d5eca0f4e3778dfef3b4d390f82d8';
