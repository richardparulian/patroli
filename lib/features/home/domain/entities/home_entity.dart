import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_entity.freezed.dart';

@freezed
abstract class HomeEntity with _$HomeEntity {
  const factory HomeEntity({
    required String id,
    required String name,
  }) = _HomeEntity;
}
