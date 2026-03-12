<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

[![pub package](https://img.shields.io/badge/pub-v1.0.8-blue?logo=dart)](https://pub.dev/packages/calendar_viewer)
[![github](https://img.shields.io/badge/github-mu7mmd-limegreen?logo=github)](https://github.com/mu7mmd)
[![linkedin](https://img.shields.io/badge/linkedin-3mdy-blue?logo=linkedin)](https://www.linkedin.com/in/3mdy)


# Calendar Viewer

A highly customizable calendar widget designed for reservations, events, and multi-language support.

<img src="https://raw.githubusercontent.com/mu7mmd/calendar_viewer/main/doc/assets/calendar.png" alt="Calendar" width="300" />

---

## Table of Contents
1. [Installing](#installing)
2. [Features](#features)
3. [Usage](#usage)
4. [Example Project](#example)
5. [Properties](#properties)
6. [Events](#events)
7. [Contributors](#contributors)

---

## 🖥 Installing <a name="installing"></a>

### Add Dependency
```yaml
dependencies:
  calendar_viewer: ^1.0.8 # Use the latest version
```

### Import Package
```dart
import 'package:calendar_viewer/calendar_viewer.dart';
```

---

## ✨ Features <a name="features"></a>
- Customizable month tabs and week bars.
- Multi-language support for month and weekday names.
- Add reservations spanning multiple dates.
- Customizable styles for dates, weekdays, and reservations.
- Support for event handling like taps and long presses on dates.

---

## 📖 Usage <a name="usage"></a>

### Basic Example:
```dart
/// Use [CalendarPageViewer] if you want to show only one month at a time.
/// with no tab bar.
///
/// Use [CalendarListViewer] if you want to show all months at a time.
/// with a scrollable list.
CalendarTabBarViewer(
  initialDate: DateTime.now(),
  months: ['Jan', 'Feb', ...], // List of 12 months
  weekdays: ['Mon', 'Tue', ...], // List of 7 weekdays
  nextMonthDateConfig: CalendarDateConfig(
      decoration: BoxDecoration(
        color: Colors.black12,
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
    ),
);
```

### Advanced Configuration:
```dart
/// Use [CalendarPageViewer] if you want to show only one month at a time.
/// with no tab bar.
///
/// Use [CalendarListViewer] if you want to show all months at a time.
/// with a scrollable list.
CalendarTabBarViewer(
  key: Key(_selectedDate.toString()),
  initialDate: _selectedDate,
  months: ['January', 'February', ...],
  weekdays: ['Monday', 'Tuesday', ...],
  dateConfigBuilder: (date) {
    if (date.isAtSameMomentAs(DateTime(_now.year, _now.month, _now.day))) {
      return CalendarDateConfig(
        decoration: BoxDecoration(
          color: Colors.teal.withValues(alpha: .6),
          borderRadius: BorderRadius.circular(5),
        ),
      );
    } else if(date.isAtSameMomentAs(_selectedDate)) {
      return CalendarDateConfig(
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: .6),
          borderRadius: BorderRadius.circular(5),
        ),
      );
    }
    return null;
  },
  reservations: [
    CalendarViewerReservation(
      from: DateTime(2023, 10, 9),
      to: DateTime(2023, 10, 13),
      user: const CalendarReservationUser(
        name: 'Mohammad Alamoudi',
        netImage:
            'https://cdn-icons-png.flaticon.com/512/9203/9203764.png',
      ),
    ),
  ],
  reservation: CalenderReservationConfig(
    style: CalendarReservationStyle(
      color: Colors.teal.withValues(alpha: .6),
    ),
  ),
  nextMonthDateConfig: CalendarDateConfig(
      decoration: BoxDecoration(
        color: Colors.black12,
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
    ),
);
```

---

## 📱 Example Project <a name="example"></a>

- **Pub Example**: Available on [pub.dev](https://pub.dev/packages/calendar_viewer/example).
- **GitHub Example Project**: Available on [GitHub](https://github.com/mu7mmd/calendar_viewer/tree/main/example).

---

## 📋 Properties <a name="properties"></a>

| Property              | Description                                                                 |
|-----------------------|-----------------------------------------------------------------------------|
| `initialDate`         | The initial date used to calculate the selected month/year.                 |
| `months`              | List of 12 month names in your app's locale.                                |
| `weekdays`            | List of 7 weekday names in your app's locale.                               |
| `reservation`         | Configures reservations (e.g., style, data).                                |
| `dateConfig`          | Default configuration for calendar dates.                                   |
| `dateConfigBuilder`   | Function to customize the style of specific dates.                          |
| `onWeekdayTap`        | Callback triggered on weekday tap with weekday and month as arguments.      |
| `customWeekdayStyle`  | Map of styles for specific weekdays (e.g., weekends).                       |
| `monthsTabBarConfig`  | Configuration for the months tab bar.                                       |
| `showNextMonthDays`   | Whether to display days from the next month in the current month's view.    |

---

## 🎯 Events <a name="events"></a>

| Event                | Description                                                                  |
|----------------------|------------------------------------------------------------------------------|
| `onWeekdayTap`       | Triggered when a weekday is tapped. Passes weekday and month.                |
| `onTap` (in dates)   | Triggered when a specific date is tapped.                                    |
| `onLongPress` (in dates) | Triggered when a specific date is long-pressed.                          |

---

## 👨🏻‍💻 Contributors <a name="contributors"></a>

- **Mohammad Alamoudi** [@mu7mmd](https://github.com/mu7mmd)

Feel free to contribute by submitting issues or feature requests on GitHub! 😊
