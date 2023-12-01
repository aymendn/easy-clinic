import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String formatDMY(String locale) {
    return DateFormat('dd MMMM yyyy', locale).format(this);
  }

  String formatMY(String locale) {
    return DateFormat('MM/yy', locale).format(this);
  }
}
