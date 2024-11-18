import 'package:flutter/material.dart';

final class CalendarMonthsTabBarConfig {
  final TabController? tabController;
  final TextStyle? unselectedLabelStyle;
  final TextStyle? selectedLabelStyle;
  final Color? unselectedLabelColor;
  final Color? selectedLabelColor;
  final Decoration? indicator;
  final double indicatorWeight;
  final double dividerHeight;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? labelPadding;
  final WidgetStateProperty<Color?>? overlayColor;
  final Color? labelColor;
  final TabAlignment? tabAlignment;
  final ValueChanged<int>? onTap;

  const CalendarMonthsTabBarConfig({
    this.tabController,
    this.unselectedLabelStyle = const TextStyle(fontWeight: FontWeight.normal),
    this.selectedLabelStyle = const TextStyle(fontWeight: FontWeight.bold),
    this.selectedLabelColor,
    this.unselectedLabelColor,
    this.indicator = const BoxDecoration(),
    this.indicatorWeight = 0,
    this.dividerHeight = 0,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.labelPadding,
    this.overlayColor,
    this.labelColor,
    this.tabAlignment,
    this.onTap,
  });
}
