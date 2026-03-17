import 'dart:async';

import 'package:patroli/core/notifications/notification_service.dart';

class NoopNotificationService implements NotificationService {
  final _notificationStreamController = StreamController<NotificationMessage>.broadcast();
  final _notificationTapStreamController = StreamController<NotificationMessage>.broadcast();

  @override
  Future<void> init() async {}

  @override
  Future<NotificationPermissionStatus> requestPermission() async {
    return NotificationPermissionStatus.notDetermined;
  }

  @override
  Future<NotificationPermissionStatus> getPermissionStatus() async {
    return NotificationPermissionStatus.notDetermined;
  }

  @override
  Future<String?> getToken() async {
    return null;
  }

  @override
  Future<void> handleBackgroundMessage(Map<String, dynamic> message) async {}

  @override
  Future<void> configureChannels() async {}

  @override
  Future<void> subscribeToTopic(String topic) async {}

  @override
  Future<void> unsubscribeFromTopic(String topic) async {}

  @override
  Future<void> showLocalNotification({required String id, required String title, required String body, String? imageUrl, Map<String, dynamic>? data, String? action, String? channel}) async {}

  @override
  Future<void> clearNotification(String id) async {}

  @override
  Future<void> clearAllNotifications() async {}

  @override
  Stream<NotificationMessage> get notificationStream => _notificationStreamController.stream;

  @override
  Stream<NotificationMessage> get notificationTapStream => _notificationTapStreamController.stream;

  void dispose() {
    _notificationStreamController.close();
    _notificationTapStreamController.close();
  }
}
