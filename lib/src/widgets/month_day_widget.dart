part of '../views/calendar_viewer.dart';

class _MonthDay extends StatelessWidget {
  const _MonthDay({
    required this.day,
    required this.config,
    required this.height,
    this.onTap,
    this.onLongPress,
  });

  final int day;
  final CalendarDateConfig config;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        splashColor: config.splashColor,
        highlightColor: config.highlightColor,
        onTap: onTap,
        onLongPress: onLongPress,
        child: _MonthDayCard(
          height: height,
          config: config,
          child: Text('$day', style: config.textStyle),
        ),
      ),
    );
  }
}
