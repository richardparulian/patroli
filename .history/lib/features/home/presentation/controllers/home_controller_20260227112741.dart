import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
class HomeController extends AsyncNotifier<int> {
  @override
  Future<int> build() async {
    // initial fetch count dari Report feature
    return 0;
  }
  
  
}
