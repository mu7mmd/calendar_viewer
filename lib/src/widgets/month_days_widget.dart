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
    required this.nextMonthDateConfig,
    required this.dateConfigBuilder,
    required this.nextMonthDateConfigBuilder,
    required this.dateCardHeight,
    required this.reservation,
  });

  final int year;
  final List<String> weekDays;
  final _MonthModel month;
  final CalendarWeekBarStyle weekBarStyle;
  final CalendarWeekdayStyle defaultWeekdayStyle;
  final Map<int, CalendarWeekdayStyle>? customWeekdayStyle;
  final ValueChanged<int>? onWeekdayTap;
  final double dateCardHeight;
  final CalendarDateConfig dateConfig;
  final CalendarDateConfig nextMonthDateConfig;
  final CalendarDateConfig? Function(DateTime)? dateConfigBuilder;
  final CalendarDateConfig? Function(DateTime)? nextMonthDateConfigBuilder;
  final CalenderReservationConfig? reservation;

  bool get _hasReservation => reservation != null;

  @override
  Widget build(BuildContext context) {
    int nextMonthDay = 0;
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
        ),
        ...List.generate(
          5,
          (weekIndex) => Stack(
            alignment: reservation?.style.alignment ?? Alignment.bottomCenter,
            children: [
              Row(
                children: List.generate(
                  7,
                  (dayIndex) {
                    final day = (weekIndex * 7) + dayIndex + 1;
                    if (day <= month.days) {
                      return _MonthDay(
                        day: day,
                        height: dateCardHeight,
                        config: dateConfigBuilder != null
                            ? dateConfigBuilder!(_getDate(day)) ?? dateConfig
                            : dateConfig,
                        onTap: dateConfig.onTap != null
                            ? () => dateConfig.onTap!(_getDate(day))
                            : null,
                        onLongPress: dateConfig.onLongPress != null
                            ? () => dateConfig.onLongPress!(_getDate(day))
                            : null,
                      );
                    } else {
                      nextMonthDay++;
                      return _MonthDay(
                        day: nextMonthDay,
                        height: dateCardHeight,
                        config: nextMonthDateConfigBuilder != null
                            ? nextMonthDateConfigBuilder!(_getDate(day)) ??
                                nextMonthDateConfig
                            : nextMonthDateConfig,
                        onTap: nextMonthDateConfig.onTap != null
                            ? () => nextMonthDateConfig.onTap!(_getDate(day))
                            : null,
                        onLongPress: nextMonthDateConfig.onLongPress != null
                            ? () =>
                                nextMonthDateConfig.onLongPress!(_getDate(day))
                            : null,
                      );
                    }
                  },
                ),
              ),
              if (_hasReservation)
                _BookedDaysUserRow(
                  year: year,
                  month: month.num,
                  weekIndex: weekIndex,
                  weekDays: weekIndex != 4 ? 7 : month.days - 28,
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
      ],
    );
  }

  DateTime _getDate(int day) => DateTime(year, month.num, day);
}
