import 'calendar_reservation_user.dart';

final class CalendarReservationData {
  final int weekDays;
  final bool hasPrevious;
  final bool hasNext;
  final CalendarReservationUser user;

  const CalendarReservationData({
    required this.weekDays,
    required this.hasPrevious,
    required this.hasNext,
    required this.user,
  });
}
