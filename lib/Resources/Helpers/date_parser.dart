import 'package:date_format/date_format.dart';

parseDate({required String date}) {
  if (date.isEmpty ||
      DateTime.tryParse(date.substring(0, date.trim().length > 10 ? 19 : 10)) ==
          null) {
    date = '0000-00-00 00:00:00';
  }
  return formatDate(
      DateTime.parse(date
          .toString()
          .trim()
          .substring(0, date.trim().length > 10 ? 19 : 10)),
      [dd, '/', mm, '/', yyyy, ' ', HH, '\\h ', nn, 'min ', ss, '\\s']);
}
