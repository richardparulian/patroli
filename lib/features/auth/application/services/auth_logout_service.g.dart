// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_logout_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authLogoutService)
const authLogoutServiceProvider = AuthLogoutServiceProvider._();

final class AuthLogoutServiceProvider
    extends
        $FunctionalProvider<
          AuthLogoutService,
          AuthLogoutService,
          AuthLogoutService
        >
    with $Provider<AuthLogoutService> {
  const AuthLogoutServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authLogoutServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authLogoutServiceHash();

  @$internal
  @override
  $ProviderElement<AuthLogoutService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthLogoutService create(Ref ref) {
    return authLogoutService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthLogoutService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthLogoutService>(value),
    );
  }
}

String _$authLogoutServiceHash() => r'cb9bd60b088863aeb1fdb5e0db3ca38f916258f8';
