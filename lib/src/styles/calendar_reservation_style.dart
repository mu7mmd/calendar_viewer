import 'package:flutter/rendering.dart';

final class CalendarReservationStyle {
  const CalendarReservationStyle({
    this.height = 26,
    this.color,
    this.padding,
    this.horizontalMargin = 0,
    this.topMargin = 0,
    this.bottomMargin = 0,
    this.radius = Radius.zero,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.alignment = Alignment.bottomCenter,
    this.showUserInStart = true,
    this.showUserInMiddles = true,
    this.showUserInEnd = true,
    this.userImageSize = 20,
    this.userNameTextStyle,
    this.gradient,
    this.boxShadow,
    this.side = BorderSide.none,
  });

  final double height;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final double horizontalMargin;
  final double topMargin;
  final double bottomMargin;
  final Radius radius;
  final MainAxisAlignment mainAxisAlignment;
  final AlignmentGeometry alignment;
  final bool showUserInStart;
  final bool showUserInMiddles;
  final bool showUserInEnd;
  final double userImageSize;
  final TextStyle? userNameTextStyle;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final BorderSide side;
}
