import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pos/features/home/domain/entities/home_entity.dart';
import 'package:pos/features/home/data/repositories/home_repository_impl.dart';

part 'get_homes_usecase.g.dart';

@riverpod
Future<List<HomeEntity>> getHomes(Ref ref) {
  return ref.watch(homeRepositoryProvider).getHomes();
}
