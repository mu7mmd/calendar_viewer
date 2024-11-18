import 'package:flutter/rendering.dart';

final class CalendarWeekdayStyle {
  final TextStyle? textStyle;
  final Alignment alignment;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;
  final Color? splashColor;
  final Color? highlightColor;

  const CalendarWeekdayStyle({
    this.textStyle,
    this.alignment = Alignment.center,
    this.padding,
    this.decoration,
    this.splashColor,
    this.highlightColor,
  });
}
