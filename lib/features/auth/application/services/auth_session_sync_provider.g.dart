// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_sync_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authSessionSyncService)
const authSessionSyncServiceProvider = AuthSessionSyncServiceProvider._();

final class AuthSessionSyncServiceProvider
    extends
        $FunctionalProvider<
          AuthSessionSyncService,
          AuthSessionSyncService,
          AuthSessionSyncService
        >
    with $Provider<AuthSessionSyncService> {
  const AuthSessionSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authSessionSyncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authSessionSyncServiceHash();

  @$internal
  @override
  $ProviderElement<AuthSessionSyncService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthSessionSyncService create(Ref ref) {
    return authSessionSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthSessionSyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthSessionSyncService>(value),
    );
  }
}

String _$authSessionSyncServiceHash() =>
    r'ce8339f3b3ca2e8c9be1b844b3d9df7dc37af86f';
