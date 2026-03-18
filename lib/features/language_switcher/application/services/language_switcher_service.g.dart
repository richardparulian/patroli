// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_switcher_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(languageSwitcherService)
const languageSwitcherServiceProvider = LanguageSwitcherServiceProvider._();

final class LanguageSwitcherServiceProvider
    extends
        $FunctionalProvider<
          LanguageSwitcherService,
          LanguageSwitcherService,
          LanguageSwitcherService
        >
    with $Provider<LanguageSwitcherService> {
  const LanguageSwitcherServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'languageSwitcherServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$languageSwitcherServiceHash();

  @$internal
  @override
  $ProviderElement<LanguageSwitcherService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LanguageSwitcherService create(Ref ref) {
    return languageSwitcherService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LanguageSwitcherService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LanguageSwitcherService>(value),
    );
  }
}

String _$languageSwitcherServiceHash() =>
    r'2983aa17bc21cda027539a4e0fc0ff8d44923aa4';
