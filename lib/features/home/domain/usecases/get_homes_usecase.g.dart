// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_homes_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getHomes)
const getHomesProvider = GetHomesProvider._();

final class GetHomesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HomeEntity>>,
          List<HomeEntity>,
          FutureOr<List<HomeEntity>>
        >
    with $FutureModifier<List<HomeEntity>>, $FutureProvider<List<HomeEntity>> {
  const GetHomesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getHomesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getHomesHash();

  @$internal
  @override
  $FutureProviderElement<List<HomeEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<HomeEntity>> create(Ref ref) {
    return getHomes(ref);
  }
}

String _$getHomesHash() => r'3067ce41c2d942b0b7583f98fdbad93e98ccba71';
