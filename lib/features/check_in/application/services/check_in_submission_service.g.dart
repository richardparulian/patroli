// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_submission_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(checkInSubmissionService)
const checkInSubmissionServiceProvider = CheckInSubmissionServiceProvider._();

final class CheckInSubmissionServiceProvider
    extends
        $FunctionalProvider<
          CheckInSubmissionService,
          CheckInSubmissionService,
          CheckInSubmissionService
        >
    with $Provider<CheckInSubmissionService> {
  const CheckInSubmissionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkInSubmissionServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkInSubmissionServiceHash();

  @$internal
  @override
  $ProviderElement<CheckInSubmissionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CheckInSubmissionService create(Ref ref) {
    return checkInSubmissionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CheckInSubmissionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CheckInSubmissionService>(value),
    );
  }
}

String _$checkInSubmissionServiceHash() =>
    r'50e63c491c3fd24b71a98364985d74dd43d954a8';
