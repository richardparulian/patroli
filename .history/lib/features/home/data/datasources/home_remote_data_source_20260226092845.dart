import 'package:pos/core/providers/network_providers.dart';
import 'package:pos/features/home/data/models/home_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'home_remote_data_source.g.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeModel>> fetchHomes();
  Future<HomeModel> fetchHome(String id);
}

@riverpod
HomeRemoteDataSource homeRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return HomeRemoteDataSourceImpl(dio);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio _dio;
  
  HomeRemoteDataSourceImpl(this._dio);

  @override
  Future<List<HomeModel>> fetchHomes() async {
    // final response = await _dio.get('/homes');
    // return (response.data as List).map((e) => HomeModel.fromJson(e)).toList();
    await Future.delayed(const Duration(seconds: 1));
    return [
      const HomeModel(id: '1', name: 'Item 1'),
      const HomeModel(id: '2', name: 'Item 2'),
    ];
  }

  @override
  Future<HomeModel> fetchHome(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    return HomeModel(id: id, name: 'Item ');
  }
}
