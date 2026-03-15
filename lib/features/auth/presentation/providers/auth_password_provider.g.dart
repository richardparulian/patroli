// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_password_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthPassword)
const authPasswordProvider = AuthPasswordProvider._();

final class AuthPasswordProvider extends $NotifierProvider<AuthPassword, bool> {
  const AuthPasswordProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authPasswordProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authPasswordHash();

  @$internal
  @override
  AuthPassword create() => AuthPassword();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$authPasswordHash() => r'43b53b85f5ef4d91b5e301b1b2aaf4a187e94d29';

abstract class _$AuthPassword extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
