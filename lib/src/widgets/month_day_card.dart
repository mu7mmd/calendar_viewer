part of '../views/calendar_viewer.dart';

class _MonthDayCard extends StatelessWidget {
  const _MonthDayCard({
    required this.height,
    required this.config,
    required this.child,
  });

  final double height;
  final CalendarDateConfig config;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: config.alignment,
      padding: config.padding,
      decoration: config.decoration,
      child: child,
    );
  }
}
