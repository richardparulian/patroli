import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

part 'home_repository_impl.g.dart';

@riverpod
HomeRepository homeRepository(Ref ref) {
  final remoteDataSource = ref.watch(homeRemoteDataSourceProvider);
  return HomeRepositoryImpl(remoteDataSource);
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<HomeEntity>> getHomes() async {
    final models = await _remoteDataSource.fetchHomes();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<HomeEntity> getHome(String id) async {
    final model = await _remoteDataSource.fetchHome(id);
    return model.toEntity();
  }
}
