// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthLogin)
const authLoginProvider = AuthLoginProvider._();

final class AuthLoginProvider
    extends $NotifierProvider<AuthLogin, ResultState<void>> {
  const AuthLoginProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authLoginProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authLoginHash();

  @$internal
  @override
  AuthLogin create() => AuthLogin();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResultState<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResultState<void>>(value),
    );
  }
}

String _$authLoginHash() => r'188a918d14e87303bc036ae47f6a82d5eac8e835';

abstract class _$AuthLogin extends $Notifier<ResultState<void>> {
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
