import 'package:pos/features/check_in/domain/entities/check_in_entity.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';

class VisitRouteArgs {
  final ScanQrEntity? scanQr;
  final CheckInEntity? checkIn; 
  final ReportsEntity? report;

  const VisitRouteArgs({
    this.scanQr,
    this.checkIn,
    this.report,
  });
}