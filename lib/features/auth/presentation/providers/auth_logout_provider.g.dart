// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_logout_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthLogout)
const authLogoutProvider = AuthLogoutProvider._();

final class AuthLogoutProvider
    extends $NotifierProvider<AuthLogout, ResultState<void>> {
  const AuthLogoutProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authLogoutProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authLogoutHash();

  @$internal
  @override
  AuthLogout create() => AuthLogout();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResultState<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResultState<void>>(value),
    );
  }
}

String _$authLogoutHash() => r'e23c7bbe2382bf2c6a88c9d1b536ad7d8e645f85';

abstract class _$AuthLogout extends $Notifier<ResultState<void>> {
  ResultState<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ResultState<void>, ResultState<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ResultState<void>, ResultState<void>>,
              ResultState<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
