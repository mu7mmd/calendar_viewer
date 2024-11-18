part of '../views/calendar_viewer.dart';

class _WeekDay extends StatelessWidget {
  const _WeekDay(this.weekday, this.day, this.style, this.onTap);

  final int weekday;
  final String day;
  final CalendarWeekdayStyle style;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        splashColor: style.splashColor,
        highlightColor: style.highlightColor,
        onTap: onTap != null ? () => onTap!(weekday) : null,
        child: Container(
          padding: style.padding,
          alignment: style.alignment,
          decoration: style.decoration,
          child: Text(
            day,
            style: style.textStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
