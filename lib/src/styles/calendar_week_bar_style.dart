import 'package:flutter/rendering.dart';

final class CalendarWeekBarStyle {
  final double height;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;

  const CalendarWeekBarStyle({
    this.height = 60,
    this.padding,
    this.decoration,
  });
}
