import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/router/app_router.dart';
import 'package:pos/features/auth/domain/entities/user_entity.dart';
import 'package:pos/features/auth/presentation/providers/auth_session_provider.dart';

void main() {
  const authenticatedUser = UserEntity(
    id: 1,
    ssoId: 1,
    username: '12345',
    name: 'Test User',
    role: 1,
    shouldChangePassword: false,
  );

  testWidgets('redirects from login to home when auth session exists', (tester) async {
    final container = ProviderContainer(
      overrides: [
        authSessionProvider.overrideWithValue(authenticatedUser),
      ],
    );
    addTearDown(container.dispose);

    final router = container.read(routerProvider);
    router.go(AppConstants.loginRoute);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(router.routeInformationProvider.value.uri.toString(), AppConstants.homeRoute);
    expect(find.byType(Scaffold), findsWidgets);
  });

  testWidgets('redirects from home to login when auth session is null', (tester) async {
    final container = ProviderContainer(
      overrides: [
        authSessionProvider.overrideWithValue(null),
      ],
    );
    addTearDown(container.dispose);

    final router = container.read(routerProvider);
    router.go(AppConstants.homeRoute);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(router.routeInformationProvider.value.uri.toString(), AppConstants.loginRoute);
    expect(find.byType(Scaffold), findsWidgets);
  });
}
