import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patroli/app/analytics/analytics_providers.dart';
import 'package:patroli/app/notifications/notification_providers.dart';
import 'package:patroli/core/notifications/notification_service.dart';

class FakeNotificationService implements NotificationService {
  final notificationController =
      StreamController<NotificationMessage>.broadcast();
  final tapController = StreamController<NotificationMessage>.broadcast();
  bool initialized = false;
  bool disposed = false;

  @override
  Future<void> init() async {
    initialized = true;
  }

  @override
  Future<void> clearAllNotifications() async {}

  @override
  Future<void> clearNotification(String id) async {}

  @override
  Future<void> configureChannels() async {}

  @override
  Future<NotificationPermissionStatus> getPermissionStatus() async {
    return NotificationPermissionStatus.authorized;
  }

  @override
  Future<String?> getToken() async => 'token';

  @override
  Future<void> handleBackgroundMessage(Map<String, dynamic> message) async {}

  @override
  Stream<NotificationMessage> get notificationStream =>
      notificationController.stream;

  @override
  Stream<NotificationMessage> get notificationTapStream => tapController.stream;

  @override
  Future<NotificationPermissionStatus> requestPermission() async {
    return NotificationPermissionStatus.authorized;
  }

  @override
  Future<void> showLocalNotification({
    required String id,
    required String title,
    required String body,
    String? imageUrl,
    Map<String, dynamic>? data,
    String? action,
    String? channel,
  }) async {}

  @override
  Future<void> subscribeToTopic(String topic) async {}

  @override
  Future<void> unsubscribeFromTopic(String topic) async {}

  void dispose() {
    disposed = true;
    notificationController.close();
    tapController.close();
  }
}

void main() {
  test('notification runtime bootstrap initializes the service', () async {
    final service = FakeNotificationService();
    final container = ProviderContainer(
      overrides: [
        notificationServiceProvider.overrideWithValue(service),
        analyticsProvider.overrideWithValue(Analytics(DebugAnalyticsService())),
      ],
    );
    addTearDown(container.dispose);

    container.read(notificationRuntimeBootstrapProvider);
    await Future<void>.delayed(Duration.zero);

    expect(service.initialized, isTrue);
  });

  test(
    'notification navigation stores pending route from tap action',
    () async {
      final service = FakeNotificationService();
      final container = ProviderContainer(
        overrides: [
          notificationServiceProvider.overrideWithValue(service),
          analyticsProvider.overrideWithValue(
            Analytics(DebugAnalyticsService()),
          ),
        ],
      );
      addTearDown(container.dispose);

      container.read(notificationNavigationProvider);

      service.tapController.add(
        const NotificationMessage(id: '1', action: '/reports/detail/1'),
      );
      await Future<void>.delayed(Duration.zero);

      final state = container.read(notificationNavigationProvider);
      expect(state.pendingRoute, '/reports/detail/1');
      expect(state.hasPendingRoute, isTrue);
      expect(state.source, NotificationNavigationSource.notificationTap);

      container
          .read(notificationNavigationProvider.notifier)
          .clearPendingRoute();

      final clearedState = container.read(notificationNavigationProvider);
      expect(clearedState.pendingRoute, isNull);
      expect(clearedState.hasPendingRoute, isFalse);
      expect(clearedState.source, NotificationNavigationSource.none);
    },
  );
}
