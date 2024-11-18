import 'package:flutter/widgets.dart';

import '../../calendar_viewer.dart';

final class CalenderReservationConfig {
  const CalenderReservationConfig({
    required this.reservations,
    this.style = const CalendarReservationStyle(),
    this.builder,
  });

  final List<CalendarViewerReservation> reservations;
  final CalendarReservationStyle style;
  final Widget Function(CalendarReservationData)? builder;

  bool get hasBuilder => builder != null;
}
