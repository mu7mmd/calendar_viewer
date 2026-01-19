import 'package:flutter/widgets.dart'
    show CrossAxisAlignment, IndexedWidgetBuilder;

final class CalendarListViewerMonthHeader {
  final double spacing;
  final CrossAxisAlignment crossAlignment;
  final IndexedWidgetBuilder? builder;

  bool get hasBuilder => builder != null;

  const CalendarListViewerMonthHeader({
    this.spacing = 8,
    this.crossAlignment = CrossAxisAlignment.start,
    this.builder,
  });
}
