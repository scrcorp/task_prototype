import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static String formatFullDate(DateTime date) {
    return DateFormat('yyyy.MM.dd (E)', 'ko').format(date);
  }

  static String formatShortDate(DateTime date) {
    return DateFormat('MM.dd').format(date);
  }

  static String formatMonthDayYear(DateTime date) {
    return DateFormat('MM/dd/yyyy').format(date);
  }

  static String formatYearMonthDay(DateTime date) {
    return DateFormat('yyyy.MM.dd').format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('yyyy.MM.dd HH:mm').format(date);
  }

  static String formatMonthDay(DateTime date) {
    return DateFormat('MM/dd').format(date);
  }
}
