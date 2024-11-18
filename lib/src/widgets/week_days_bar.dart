part of '../views/calendar_viewer.dart';

class _WeekDaysBar extends StatelessWidget {
  const _WeekDaysBar(
    this.year,
    this.month,
    this.days,
    this.barStyle,
    this.onTap,
    this.dayStyleBuilder,
  );

  final int year;
  final int month;
  final List<String> days;
  final CalendarWeekBarStyle barStyle;
  final ValueChanged<int>? onTap;
  final CalendarWeekdayStyle Function(int) dayStyleBuilder;

  @override
  Widget build(BuildContext context) {
    int weekdayIndex = DateTime(year, month).weekday - 1;
    return Container(
      height: barStyle.height,
      padding: barStyle.padding,
      decoration: barStyle.decoration,
      child: Row(
        children: days.map((_) {
          if (weekdayIndex == 7) weekdayIndex = 0;
          final weekday = weekdayIndex + 1;
          return _WeekDay(
            weekday,
            days[weekdayIndex++],
            dayStyleBuilder(weekday),
            onTap,
          );
        }).toList(),
      ),
    );
  }
}
