import 'package:flutter_test/flutter_test.dart';
import 'package:patroli/app/constants/app_routes.dart';

void main() {
  group('AppRoutes', () {
    test('history report path matches router structure', () {
      expect(AppRoutes.historyReport, '/home/history');
    });

    test('report detail path stays nested under history report', () {
      expect(
        AppRoutes.reportDetail,
        '${AppRoutes.historyReport}/report_detail',
      );
    });

    test('settings and language switcher paths stay nested correctly', () {
      expect(AppRoutes.settings, '/home/settings');
      expect(
        AppRoutes.languageSwitcher,
        '${AppRoutes.settings}/language_switcher',
      );
    });
  });
}
