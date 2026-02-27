import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';
import '../../data/repositories/home_repository_impl.dart';

part 'get_homes_usecase.g.dart';

@riverpod
Future<List<HomeEntity>> getHomes(Ref ref) {
  return ref.watch(homeRepositoryProvider).getHomes();
}
