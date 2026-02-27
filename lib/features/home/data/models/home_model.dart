import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/home_entity.dart';

part 'home_model.freezed.dart';
part 'home_model.g.dart';

@freezed
abstract class HomeModel with _$HomeModel {
  const HomeModel._();

  const factory HomeModel({
    required String id,
    required String name,
  }) = _HomeModel;

  factory HomeModel.fromJson(Map<String, dynamic> json) => 
      _$HomeModelFromJson(json);

  HomeEntity toEntity() => HomeEntity(id: id, name: name);
}
