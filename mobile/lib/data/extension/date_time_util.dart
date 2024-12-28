import 'package:intl/intl.dart';

String formatUserFriendlyDate(String isoDate) {
  final dateTime = DateTime.parse(isoDate);
  final localDateTime = dateTime.toLocal();
  return DateFormat('EEEE, MMM d, y h:mm a').format(localDateTime);
}