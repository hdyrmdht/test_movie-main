import 'package:intl/intl.dart';

String formatMovieDate(String? releaseDate) {
  if (releaseDate == null || releaseDate.isEmpty) {
    return "N/A";
  }
  DateTime dateTime = DateFormat('yyyy-MM-dd').parse(releaseDate);
  return DateFormat.yMMMEd().format(dateTime);
}
