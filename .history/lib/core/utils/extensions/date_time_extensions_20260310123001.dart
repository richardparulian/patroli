import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {

  /// 2026-03-10
  String get yMd => DateFormat('yyyy-MM-dd').format(this);

  /// 10-03-2026
  String get dMy => DateFormat('dd-MM-yyyy').format(this);

  /// 10/03/2026
  String get dMySlash => DateFormat('dd/MM/yyyy').format(this);

  /// 10 Mar 2026
  String get dMMMMy => DateFormat('dd MMM yyyy').format(this);

  /// 10 Maret 2026
  String get dMMMMY => DateFormat('dd MMMM yyyy', 'id_ID').format(this);

  /// Selasa, 10 Maret 2026
  String get fullDate => DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(this);

  /// 10 Mar
  String get dMMM => DateFormat('dd MMM').format(this);

  /// Mar 2026
  String get mMMMMy => DateFormat('MMMM yyyy', 'id_ID').format(this);

  /// 2026
  String get year => DateFormat('yyyy').format(this);

  /// Maret
  String get monthName => DateFormat('MMMM', 'id_ID').format(this);

  /// Mar
  String get monthShort => DateFormat('MMM').format(this);

  /// Senin
  String get dayName => DateFormat('EEEE', 'id_ID').format(this);

  /// Sen
  String get dayShort => DateFormat('EEE', 'id_ID').format(this);

  /// 14:30
  String get hm => DateFormat('HH:mm').format(this);

  /// 14:30:22
  String get hms => DateFormat('HH:mm:ss').format(this);

  /// 10 Mar 2026 14:30
  String get dateTime => DateFormat('dd MMM yyyy HH:mm').format(this);

  /// Selasa, 10 Mar 2026 14:30
  String get fullDateTime => DateFormat('EEEE, dd MMM yyyy HH:mm', 'id_ID').format(this);

  /// ISO format
  String get iso => toIso8601String();

  /// 10 Mar 2026 • 14:30
  String get pretty => DateFormat('dd MMM yyyy • HH:mm').format(this);

}

extension StringDateParser on String {

  DateTime? toDate() {
    final date = DateTime.tryParse(this);
    return date?.toLocal();
  }

  String toFormattedDate() {
    final date = DateTime.tryParse(this)?.toLocal();
    if (date == null) return '';
    return DateFormat('dd MMM yyyy', 'id_ID').format(date);
  }

  String toFullDate() {
    final date = DateTime.tryParse(this)?.toLocal();
    if (date == null) return '';
    return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(date);
  }

  String toDateTime() {
    final date = DateTime.tryParse(this)?.toLocal();
    if (date == null) return '';
    return DateFormat('dd MMM yyyy HH:mm', 'id_ID').format(date);
  }

  /// 14:30
  String toTime() {
    final date = DateTime.tryParse(this)?.toLocal();
    if (date == null) return '';
    return DateFormat('HH:mm').format(date);
  }

  /// 14:30 WIB
  String toTimeWithZone() {
    final date = DateTime.tryParse(this)?.toLocal();
    if (date == null) return '';

    final time = DateFormat('HH:mm').format(date);
    final zone = date.timeZoneName;

    return '$time $zone';
  }

  String toTimeWithOffset() {
    final date = DateTime.tryParse(this)?.toLocal();
    if (date == null) return '';

    final time = DateFormat('HH:mm').format(date);

    final offset = date.timeZoneOffset;
    final sign = offset.isNegative ? '-' : '+';
    final hours = offset.inHours.abs().toString().padLeft(2, '0');
    final minutes = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');

    return '$time GMT$sign$hours:$minutes';
  }

  bool get isValidDate {
    return DateTime.tryParse(this) != null;
  }
}