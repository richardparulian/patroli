import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/app/analytics/analytics_providers.dart';
import 'package:patroli/core/notifications/debug_notification_service.dart';
import 'package:patroli/core/notifications/noop_notification_service.dart';
import 'package:patroli/core/notifications/notification_service.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return kDebugMode
      ? DebugNotificationService() as NotificationService
      : NoopNotificationService();
});

final notificationRuntimeBootstrapProvider = Provider<void>((ref) {
  final service = ref.watch(notificationServiceProvider);
  final analytics = ref.watch(analyticsProvider);

  unawaited(service.init());

  final notificationSub = service.notificationStream.listen((notification) {
    analytics.logUserAction(
      action: 'notification_received',
      category: 'notification',
      label: notification.channel ?? 'default',
      parameters: {
        'notification_id': notification.id,
        'title': notification.title,
        'foreground': notification.foreground,
      },
    );
  });

  final tapSub = service.notificationTapStream.listen((notification) {
    analytics.logUserAction(
      action: 'notification_tapped',
      category: 'notification',
      label: notification.channel ?? 'default',
      parameters: {
        'notification_id': notification.id,
        'action': notification.action,
      },
    );
  });

  ref.onDispose(() {
    notificationSub.cancel();
    tapSub.cancel();

    if (service is DebugNotificationService) {
      service.dispose();
    } else if (service is NoopNotificationService) {
      service.dispose();
    }
  });
});

final notificationsEnabledProvider = FutureProvider<bool>((ref) async {
  ref.watch(notificationRuntimeBootstrapProvider);

  final service = ref.watch(notificationServiceProvider);
  final status = await service.getPermissionStatus();
  return status == NotificationPermissionStatus.authorized ||
      status == NotificationPermissionStatus.provisional;
});

class NotificationNavigationState {
  const NotificationNavigationState({
    this.pendingRoute,
    this.source = NotificationNavigationSource.none,
  });

  final String? pendingRoute;
  final NotificationNavigationSource source;

  NotificationNavigationState copyWith({
    Object? pendingRoute = _unset,
    NotificationNavigationSource? source,
  }) {
    return NotificationNavigationState(
      pendingRoute: identical(pendingRoute, _unset)
          ? this.pendingRoute
          : pendingRoute as String?,
      source: source ?? this.source,
    );
  }

  bool get hasPendingRoute =>
      pendingRoute != null && pendingRoute!.trim().isNotEmpty;
}

enum NotificationNavigationSource { none, notificationTap }

const _unset = Object();

class NotificationNavigationController
    extends Notifier<NotificationNavigationState> {
  @override
  NotificationNavigationState build() {
    ref.watch(notificationRuntimeBootstrapProvider);

    final service = ref.watch(notificationServiceProvider);
    final sub = service.notificationTapStream.listen(_handleNotificationTap);

    ref.onDispose(sub.cancel);

    return const NotificationNavigationState();
  }

  void clearPendingRoute() {
    state = const NotificationNavigationState();
  }

  void _handleNotificationTap(NotificationMessage notification) {
    final action = notification.action;
    if (action == null || action.trim().isEmpty) return;

    state = NotificationNavigationState(
      pendingRoute: action,
      source: NotificationNavigationSource.notificationTap,
    );
  }
}

final notificationNavigationProvider =
    NotifierProvider<
      NotificationNavigationController,
      NotificationNavigationState
    >(NotificationNavigationController.new);
