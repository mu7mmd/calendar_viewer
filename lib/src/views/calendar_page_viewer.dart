part of 'calendar_viewer.dart';

/// A highly customizable calendar widget designed for displaying calendars
/// with support for reservations, events, and multi-language translations.
///
/// The [CalendarPageViewer] widget allows you to create a beautiful and functional calendar
/// with month tabs, customizable week bars, date styles, and reservations. It also supports
/// passing your custom translations for weekdays.
///
/// ## Features:
/// - Customizable weekday tabs.
/// - Event handling for user interactions.
/// - Style individual dates or weekdays.
/// - Add reservations spanning multiple dates.
/// - Multi-language support by passing translated names for weekdays.
///
/// ## Usage:
/// ```dart
/// CalendarPageViewer(
///   initialDate: DateTime.now(),
///   weekdays: ['Mon', 'Tue', ...], // List of 7 weekdays
///   onWeekdayTap: (weekday, month) {
///     print('Tapped weekday: $weekday in month: $month');
///   },
/// );
/// ```
///
/// For advanced configurations, explore the various parameters for customization.
class CalendarPageViewer extends StatelessWidget {
  /// Creates a [CalendarPageViewer].
  ///
  /// The [months] must contain exactly 12 entries, and [weekdays] must contain exactly 7 entries.
  /// If a [TabController] is provided, its length must also equal 12.
  const CalendarPageViewer({
    super.key,
    this.height = 420,
    this.pageController,
    this.physics,
    required this.initialDate,
    required this.weekdays,
    this.weekBarStyle = const CalendarWeekBarStyle(),
    this.weekdayStyle = const CalendarWeekdayStyle(),
    this.customWeekdayStyle,
    this.onWeekdayTap,
    this.dateConfig = const CalendarDateConfig(),
    this.dateConfigBuilder,
    this.nextMonthDateConfig = const CalendarDateConfig(),
    this.nextMonthDateConfigBuilder,
    this.reservation,
    this.showNextMonthDays = true,
  }) : assert(weekdays.length == 7);

  /// The height of the week bar and dates section in the calendar.
  final double height;

  /// A [PageController] for controlling month tabs. Optional; if provided, its length must be 12.
  final PageController? pageController;

  /// The physics of the list view.
  final ScrollPhysics? physics;

  /// The initial date used to select the starting month and calculate year-based dates.
  final DateTime initialDate;

  /// List of weekday names, typically in your app's locale. Must contain exactly 7 entries.
  ///
  /// **Important:** The weekdays must start with Monday, following the ISO 8601 standard.
  /// This is necessary to calculate the correct dates for the calendar.
  ///
  /// Example: `['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']`.
  final List<String> weekdays;

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
  final void Function(int weekday, int month)? onWeekdayTap;

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

  /// Whether to show dates of the following month in the current month's calendar.
  final bool showNextMonthDays;

  @override
  Widget build(BuildContext context) {
    final monthsModels = [
      const _MonthModel(1, 'January', 31),
      _MonthModel(2, 'February', _checkFebLeap(initialDate.year)),
      const _MonthModel(3, 'March', 31),
      const _MonthModel(4, 'April', 30),
      const _MonthModel(5, 'May', 31),
      const _MonthModel(6, 'June', 30),
      const _MonthModel(7, 'July', 31),
      const _MonthModel(8, 'August', 31),
      const _MonthModel(9, 'September', 30),
      const _MonthModel(10, 'October', 31),
      const _MonthModel(11, 'November', 30),
      const _MonthModel(12, 'December', 31),
    ];

    return SizedBox(
      height: height,
      child: PageView.builder(
        controller: pageController,
        physics: physics,
        itemBuilder: (context, index) {
          final month = monthsModels[index];
          return _MonthDaysWidget(
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
            showNextMonthDays: showNextMonthDays,
          );
        },
      ),
    );
  }
}
