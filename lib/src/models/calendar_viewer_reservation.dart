import '../../calendar_viewer_models.dart';

final class CalendarViewerReservation {
  const CalendarViewerReservation({
    required this.from,
    required this.to,
    required this.user,
  });

  final DateTime from;
  final DateTime to;
  final CalendarReservationUser user;
}
