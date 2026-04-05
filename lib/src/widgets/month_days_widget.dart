part of '../views/calendar_viewer.dart';

class _MonthDaysWidget extends StatelessWidget {
  const _MonthDaysWidget(
    this.month, {
    required this.year,
    required this.weekDays,
    required this.weekBarStyle,
    required this.defaultWeekdayStyle,
    required this.customWeekdayStyle,
    required this.onWeekdayTap,
    required this.dateConfig,
    required this.outsideDateConfig,
    required this.dateConfigBuilder,
    required this.outsideDateConfigBuilder,
    required this.dateCardHeight,
    required this.reservation,
    required this.rowSpacing,
    required this.showOutsideDays,
    this.startWeekday,
    required this.alwaysShowFullRows,
  });

  /// The starting weekday of the calendar (1 = Monday, 7 = Sunday). If null, dynamically shifts.
  final int? startWeekday;

  /// Whether to always render the maximum structural rows (6 for Sunday-start, 5 for standard)
  /// so that the calendar maintains a consistent layout height across all months.
  final bool alwaysShowFullRows;

  final int year;
  final _MonthModel month;
  final List<String> weekDays;
  final CalendarWeekBarStyle weekBarStyle;
  final CalendarWeekdayStyle defaultWeekdayStyle;
  final Map<int, CalendarWeekdayStyle>? customWeekdayStyle;
  final ValueChanged<int>? onWeekdayTap;
  final double dateCardHeight;
  final CalendarDateConfig dateConfig;
  final CalendarDateConfig outsideDateConfig;
  final CalendarDateConfig? Function(DateTime)? dateConfigBuilder;
  final CalendarDateConfig? Function(DateTime)? outsideDateConfigBuilder;
  final CalenderReservationConfig? reservation;
  final double rowSpacing;
  final bool showOutsideDays;

  bool get _hasReservation => reservation != null;

  @override
  Widget build(BuildContext context) {
    int nextMonthDay = 0;
    int startOffset = 0;
    if (startWeekday != null) {
      final firstDayOfMonth = DateTime(year, month.num, 1);
      final firstWeekday = firstDayOfMonth.weekday; // 1 = Monday, 7 = Sunday
      // Calculate how many days we need to offset from the target startWeekday
      startOffset = (firstWeekday - startWeekday!) % 7;
      if (startOffset < 0) startOffset += 7;
    }

    final int rowsCount = alwaysShowFullRows 
        ? (startWeekday != null ? 6 : 5) 
        : ((startOffset + month.days) > 35 ? 6 : ((startOffset + month.days) > 28 ? 5 : 4));

    // The parent calculates dateCardHeight assuming 5 rows and 0 spacing.
    final double totalGridHeight = dateCardHeight * 5;
    // We perfectly distribute the available height across the actual rows.
    final double trueRowHeight =
        (totalGridHeight - ((rowsCount - 1) * rowSpacing)) / rowsCount;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _WeekDaysBar(
          year,
          month.num,
          weekDays,
          weekBarStyle,
          onWeekdayTap,
          (weekday) => customWeekdayStyle?[weekday] ?? defaultWeekdayStyle,
          startWeekday,
        ),
        Column(
          spacing: rowSpacing,
          children: List.generate(
            rowsCount,
            (weekIndex) => Stack(
              alignment: reservation?.style.alignment ?? Alignment.bottomCenter,
              children: [
                Row(
                  children: List.generate(
                    7,
                    (dayIndex) {
                      final cellIndex = (weekIndex * 7) + dayIndex + 1;
                      final day = cellIndex - startOffset;
                      final date = _getDate(day);

                      if (day <= 0) {
                        if (showOutsideDays) {
                          final config = outsideDateConfigBuilder?.call(date) ??
                              outsideDateConfig;
                          return _MonthDay(
                            day: date.day,
                            height: trueRowHeight,
                            config: config,
                            onTap: config.hasOnTap
                                ? () => config.onTap!(date)
                                : null,
                            onLongPress: config.hasOnLongPress
                                ? () => config.onLongPress!(date)
                                : null,
                          );
                        } else {
                          return const Spacer();
                        }
                      } else if (day <= month.days) {
                        final config =
                            dateConfigBuilder?.call(date) ?? dateConfig;
                        return _MonthDay(
                          day: day,
                          height: trueRowHeight,
                          config: config,
                          onTap: config.hasOnTap
                              ? () => config.onTap!(date)
                              : null,
                          onLongPress: config.hasOnLongPress
                              ? () => config.onLongPress!(date)
                              : null,
                        );
                      } else if (showOutsideDays) {
                        nextMonthDay++;
                        final config = outsideDateConfigBuilder?.call(date) ??
                            outsideDateConfig;
                        return _MonthDay(
                          day: nextMonthDay,
                          height: trueRowHeight,
                          config: config,
                          onTap: config.hasOnTap
                              ? () => config.onTap!(date)
                              : null,
                          onLongPress: config.hasOnLongPress
                              ? () => config.onLongPress!(date)
                              : null,
                        );
                      } else {
                        return const Spacer();
                      }
                    },
                  ),
                ),
                if (_hasReservation)
                  _BookedDaysUserRow(
                    year: year,
                    month: month.num,
                    weekIndex: weekIndex,
                    startOffset: startOffset,
                    weekDays: weekIndex != (rowsCount - 1)
                        ? 7
                        : (month.days + startOffset) - ((rowsCount - 1) * 7),
                    dayBuilder: (date) =>
                        _dayBuilder(date, reservation!.reservations),
                    childBuilder: !reservation!.hasBuilder
                        ? (data) => Expanded(
                              flex: data.weekDays,
                              child: _UserContainer(
                                data: data,
                                style: reservation!.style,
                              ),
                            )
                        : (data) => Expanded(
                              flex: data.weekDays,
                              child: reservation!.builder!(data),
                            ),
                  )
              ],
            ),
          ),
        )
      ],
    );
  }

  DateTime _getDate(int day) => DateTime(year, month.num, day);
}
