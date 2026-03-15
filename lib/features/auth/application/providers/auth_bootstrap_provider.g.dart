// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_bootstrap_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authBootstrap)
const authBootstrapProvider = AuthBootstrapProvider._();

final class AuthBootstrapProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  const AuthBootstrapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authBootstrapProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authBootstrapHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return authBootstrap(ref);
  }
}

String _$authBootstrapHash() => r'5c7b2089644ed653093dcbadec48560aad933ec4';
