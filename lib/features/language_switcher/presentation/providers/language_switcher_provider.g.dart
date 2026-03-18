// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_switcher_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LanguageSwitcher)
const languageSwitcherProvider = LanguageSwitcherProvider._();

final class LanguageSwitcherProvider
    extends
        $AsyncNotifierProvider<LanguageSwitcher, List<LanguageSwitcherEntity>> {
  const LanguageSwitcherProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'languageSwitcherProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$languageSwitcherHash();

  @$internal
  @override
  LanguageSwitcher create() => LanguageSwitcher();
}

String _$languageSwitcherHash() => r'0486a91196a8e9b3d0f1b3c7c9895b14bb01e9f8';

abstract class _$LanguageSwitcher
    extends $AsyncNotifier<List<LanguageSwitcherEntity>> {
  FutureOr<List<LanguageSwitcherEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<LanguageSwitcherEntity>>,
              List<LanguageSwitcherEntity>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<LanguageSwitcherEntity>>,
                List<LanguageSwitcherEntity>
              >,
              AsyncValue<List<LanguageSwitcherEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
