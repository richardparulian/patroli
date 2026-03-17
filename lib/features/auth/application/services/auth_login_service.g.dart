// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authLoginService)
const authLoginServiceProvider = AuthLoginServiceProvider._();

final class AuthLoginServiceProvider
    extends
        $FunctionalProvider<
          AuthLoginService,
          AuthLoginService,
          AuthLoginService
        >
    with $Provider<AuthLoginService> {
  const AuthLoginServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authLoginServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authLoginServiceHash();

  @$internal
  @override
  $ProviderElement<AuthLoginService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthLoginService create(Ref ref) {
    return authLoginService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthLoginService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthLoginService>(value),
    );
  }
}

String _$authLoginServiceHash() => r'45ed9de8d320840e9f70621f1f12030e29ae737a';
