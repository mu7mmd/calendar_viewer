part of '../views/calendar_viewer.dart';

int _checkFebLeap(int year) {
  if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
    return 29;
  } else {
    return 28;
  }
}

_IsDayReserved _dayBuilder(
  DateTime date,
  List<CalendarViewerReservation> reservations,
) {
  for (final reserve in reservations) {
    final from = reserve.from;
    final to = reserve.to;
    if ((date.isAfter(from) || date.isAtSameMomentAs(from)) &&
        date.isBefore(to)) {
      return (isReserved: true, user: reserve.user);
    }
  }
  return (isReserved: false, user: null);
}
