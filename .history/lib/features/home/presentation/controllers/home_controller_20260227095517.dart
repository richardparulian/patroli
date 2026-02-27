import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/usecases/get_homes_usecase.dart';

part 'home_controller.g.dart';

@riverpod
class HomeController extends _$HomeController {
  @override
  FutureOr<List<HomeEntity>> build() {
    return ref.watch(getHomesProvider.future);
  }
  
  Future<void> refresh() async {
     state = const AsyncValue.loading();
     state = await AsyncValue.guard(() => ref.refresh(getHomesProvider.future));
  }
}
