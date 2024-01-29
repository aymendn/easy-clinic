import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String formatDMY() {
    return DateFormat('dd MMMM yyyy').format(this);
  }
}
