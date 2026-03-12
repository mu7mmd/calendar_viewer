import 'package:flutter/material.dart';

class CalendarDateConfig {
  final Color? splashColor;
  final Color? highlightColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Alignment alignment;
  final Decoration? decoration;
  final ValueChanged<DateTime>? onTap;
  final ValueChanged<DateTime>? onLongPress;

  bool get hasOnTap => onTap != null;

  bool get hasOnLongPress => onLongPress != null;

  const CalendarDateConfig({
    this.splashColor,
    this.highlightColor,
    this.textStyle,
    this.padding,
    this.margin,
    this.alignment = Alignment.center,
    this.decoration = const BoxDecoration(
      border: Border(
        top: BorderSide(color: Colors.black12, width: 0.5),
        left: BorderSide(color: Colors.black12, width: 0.5),
        right: BorderSide(color: Colors.black12, width: 0.5),
        bottom: BorderSide(color: Colors.black12, width: 0.5),
      ),
    ),
    this.onTap,
    this.onLongPress,
  });
}
