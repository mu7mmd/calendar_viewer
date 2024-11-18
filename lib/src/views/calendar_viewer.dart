import 'package:flutter/material.dart';

import '../configs/configs.dart';
import '../models/models.dart';
import '../styles/styles.dart';

part '../widgets/week_day_text.dart';

part '../widgets/month_days_widget.dart';

part '../widgets/month_day_widget.dart';

part '../widgets/month_day_card.dart';

part '../widgets/booked_days_user_row.dart';

part '../widgets/week_days_bar.dart';

part '../widgets/user_container.dart';

part '../models/month_model.dart';

part '../models/reservation_day.dart';

part '../models/is_day_reserved.dart';

part '../helpers/helpers.dart';

/// A highly customizable calendar widget designed for displaying calendars
/// with support for reservations, events, and multi-language translations.
///
/// The [CalendarViewer] widget allows you to create a beautiful and functional calendar
/// with month tabs, customizable week bars, date styles, and reservations. It also supports
/// passing your custom translations for months and weekdays.
///
/// ## Features:
/// - Customizable month and weekday tabs.
/// - Event handling for user interactions.
/// - Style individual dates or weekdays.
/// - Add reservations spanning multiple dates.
/// - Multi-language support by passing translated names for months and weekdays.
///
/// ## Usage:
/// ```dart
/// CalendarViewer(
///   initialDate: DateTime.now(),
///   months: ['January', 'February', ...], // List of 12 months
///   weekdays: ['Mon', 'Tue', ...], // List of 7 weekdays
///   onWeekdayTap: (weekday, month) {
///     print('Tapped weekday: $weekday in month: $month');
///   },
/// );
/// ```
///
/// For advanced configurations, explore the various parameters for customization.
class CalendarViewer extends StatelessWidget {
  /// Creates a [CalendarViewer].
  ///
  /// The [months] must contain exactly 12 entries, and [weekdays] must contain exactly 7 entries.
  /// If a [TabController] is provided, its length must also equal 12.
  const CalendarViewer({
    super.key,
    this.height = 420,
    this.tabController,
    required this.initialDate,
    required this.months,
    required this.weekdays,
    this.monthsTabBarConfig = const CalendarMonthsTabBarConfig(),
    this.weekBarStyle = const CalendarWeekBarStyle(),
    this.weekdayStyle = const CalendarWeekdayStyle(),
    this.customWeekdayStyle,
    this.onWeekdayTap,
    this.dateConfig = const CalendarDateConfig(),
    this.dateConfigBuilder,
    this.nextMonthDateConfig = const CalendarDateConfig(),
    this.nextMonthDateConfigBuilder,
    this.reservation,
  }) : assert(months.length == 12 &&
            weekdays.length == 7 &&
            (tabController == null || tabController.length == 12));

  /// The height of the week bar and dates section in the calendar.
  final double height;

  /// A [TabController] for controlling month tabs. Optional; if provided, its length must be 12.
  final TabController? tabController;

  /// The initial date used to select the starting month and calculate year-based dates.
  final DateTime initialDate;

  /// List of month names, typically in your app's locale. Must contain exactly 12 entries.
  ///
  /// **Important:** The months must start with January to ensure proper functionality of the calendar.
  ///
  /// Example: `['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']`.
  final List<String> months;

  /// List of weekday names, typically in your app's locale. Must contain exactly 7 entries.
  ///
  /// **Important:** The weekdays must start with Monday, following the ISO 8601 standard.
  /// This is necessary to calculate the correct dates for the calendar.
  ///
  /// Example: `['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']`.
  final List<String> weekdays;

  /// Configuration for styling and properties of the months tab bar.
  final CalendarMonthsTabBarConfig monthsTabBarConfig;

  /// Style settings for the container surrounding weekday names.
  final CalendarWeekBarStyle weekBarStyle;

  /// Default style for weekday text and other properties.
  final CalendarWeekdayStyle weekdayStyle;

  /// Custom styles for specific weekdays.
  ///
  /// Provide a map where the key is the weekday number (ISO 8601 format: Monday = 1, Sunday = 7)
  /// and the value is the style for that day. Days not included in the map will use [weekdayStyle].
  final Map<int, CalendarWeekdayStyle>? customWeekdayStyle;

  /// Callback triggered when the user taps on a specific weekday.
  ///
  /// The callback receives two parameters:
  /// - The tapped weekday number (1–7).
  /// - The current month number (1–12).
  ///
  /// onWeekdayTap: (weekday, month) {}
  final Function(int weekday, int month)? onWeekdayTap;

  /// Default style and properties for calendar dates.
  final CalendarDateConfig dateConfig;

  /// Style and properties for dates of the following month displayed in the current month's calendar.
  final CalendarDateConfig nextMonthDateConfig;

  /// A function to provide custom styles for specific dates.
  ///
  /// Return a [CalendarDateConfig] for the given date, or `null` to use [dateConfig] as default.
  final CalendarDateConfig? Function(DateTime)? dateConfigBuilder;

  /// A function to provide custom styles for next-month dates.
  ///
  /// Return a [CalendarDateConfig] for the given date, or `null` to use [nextMonthDateConfig] as default.
  final CalendarDateConfig? Function(DateTime)? nextMonthDateConfigBuilder;

  /// Configuration for displaying reservations on the calendar.
  ///
  /// Reservations span multiple dates and are styled based on the [CalenderReservationConfig].
  final CalenderReservationConfig? reservation;

  @override
  Widget build(BuildContext context) {
    final monthsModels = [
      _MonthModel(1, months[0], 31),
      _MonthModel(2, months[1], _checkFebLeap(initialDate.year)),
      _MonthModel(3, months[2], 31),
      _MonthModel(4, months[3], 30),
      _MonthModel(5, months[4], 31),
      _MonthModel(6, months[5], 30),
      _MonthModel(7, months[6], 31),
      _MonthModel(8, months[7], 31),
      _MonthModel(9, months[8], 30),
      _MonthModel(10, months[9], 31),
      _MonthModel(11, months[10], 30),
      _MonthModel(12, months[11], 31),
    ];

    return DefaultTabController(
      length: 12,
      initialIndex: initialDate.month - 1,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            controller: tabController,
            overlayColor: monthsTabBarConfig.overlayColor,
            labelColor: monthsTabBarConfig.selectedLabelColor,
            labelStyle: monthsTabBarConfig.selectedLabelStyle,
            unselectedLabelStyle: monthsTabBarConfig.unselectedLabelStyle,
            unselectedLabelColor: monthsTabBarConfig.unselectedLabelColor,
            indicator: monthsTabBarConfig.indicator,
            indicatorWeight: monthsTabBarConfig.indicatorWeight,
            dividerHeight: monthsTabBarConfig.dividerHeight,
            labelPadding: monthsTabBarConfig.labelPadding,
            padding: monthsTabBarConfig.padding,
            tabAlignment: monthsTabBarConfig.tabAlignment,
            onTap: monthsTabBarConfig.onTap,
            tabs: List.generate(12, (i) => Text(months[i])),
          ),
          SizedBox(
            height: height,
            child: TabBarView(
              controller: tabController,
              children: monthsModels
                  .map((month) => _MonthDaysWidget(
                        month,
                        year: initialDate.year,
                        weekDays: weekdays,
                        weekBarStyle: weekBarStyle,
                        defaultWeekdayStyle: weekdayStyle,
                        customWeekdayStyle: customWeekdayStyle,
                        onWeekdayTap: onWeekdayTap != null
                            ? (weekday) => onWeekdayTap!(weekday, month.num)
                            : null,
                        dateConfig: dateConfig,
                        nextMonthDateConfig: nextMonthDateConfig,
                        dateCardHeight: (height - weekBarStyle.height) / 5,
                        dateConfigBuilder: dateConfigBuilder,
                        nextMonthDateConfigBuilder: nextMonthDateConfigBuilder,
                        reservation: reservation,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
