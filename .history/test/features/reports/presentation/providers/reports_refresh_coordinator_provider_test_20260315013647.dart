import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pos/features/reports/providers/reports_refresh_coordinator_provider.dart';

class MockReportsRefreshCoordinator extends Mock implements ReportsRefreshCoordinator {}

void main() {
  late MockReportsRefreshCoordinator coordinator;

  setUp(() {
    coordinator = MockReportsRefreshCoordinator();
  });

  test('refreshReportsAndDashboard can be invoked', () async {
    when(() => coordinator.refreshReportsAndDashboard())
        .thenAnswer((_) async {});

    await coordinator.refreshReportsAndDashboard();

    verify(() => coordinator.refreshReportsAndDashboard()).called(1);
  });

  test('refreshDashboardOnly can be invoked', () async {
    when(() => coordinator.refreshDashboardOnly())
        .thenAnswer((_) async {});

    await coordinator.refreshDashboardOnly();

    verify(() => coordinator.refreshDashboardOnly()).called(1);
  });

  test('refreshReportsOnly can be invoked', () {
    when(() => coordinator.refreshReportsOnly()).thenReturn(null);

    coordinator.refreshReportsOnly();

    verify(() => coordinator.refreshReportsOnly()).called(1);
  });
}
