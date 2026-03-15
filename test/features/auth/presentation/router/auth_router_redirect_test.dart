import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pos/core/router/session_router_refresh.dart';
import 'package:pos/features/auth/application/providers/auth_session_provider.dart';
import 'package:pos/features/auth/domain/entities/user_entity.dart';

void main() {
  const authenticatedUser = UserEntity(
    id: 1,
    ssoId: 1,
    username: '12345',
    name: 'Test User',
    role: 1,
    shouldChangePassword: false,
  );

  test('router refresh notifier notifies when auth session changes', () {
    final routerRefreshProvider = Provider((ref) => RouterRefreshNotifier(ref));
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(routerRefreshProvider);
    var notifyCount = 0;
    notifier.addListener(() {
      notifyCount++;
    });

    container.read(authSessionProvider.notifier).setUser(authenticatedUser);
    container.read(authSessionProvider.notifier).clear();

    expect(notifyCount, 2);
  });
}
