import 'package:intl/intl.dart';

class FormatHelper {
  static String shortDate(DateTime date) {
    final dateFormat = DateFormat.MMMEd('en');
    return dateFormat.format(date);
  }
}
