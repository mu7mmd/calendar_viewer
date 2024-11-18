part of '../views/calendar_viewer.dart';

class _BookedDaysUserRow extends StatelessWidget {
  const _BookedDaysUserRow({
    required this.year,
    required this.month,
    required this.weekIndex,
    required this.weekDays,
    required this.dayBuilder,
    required this.childBuilder,
  });

  final int year;
  final int month;
  final int weekIndex;
  final int weekDays;
  final _IsDayReserved Function(DateTime) dayBuilder;
  final Widget Function(CalendarReservationData) childBuilder;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: days().map((day) {
        final flex = (day.end - day.start) + 1;
        final user = day.user;
        if (user == null) {
          return Spacer(flex: flex);
        } else {
          final hasPrevious = day.hasPrevious!;
          final hasNext = day.hasNext!;
          return childBuilder(
            CalendarReservationData(
              weekDays: flex,
              hasPrevious: hasPrevious,
              hasNext: hasNext,
              user: user,
            ),
          );
        }
      }).toList(),
    );
  }

  List<_ReservationDay> days() {
    List<_ReservationDay> result = [];

    _IsDayReserved getDay(int dayIndex) {
      // Your logic to retrieve a day's booking info
      final date = _getDate((weekIndex * 7) + dayIndex); // Get the date
      return dayBuilder(date); // Retrieve the day model
    }

    int start = 1;
    while (start <= weekDays) {
      final day = getDay(start);

      if (day.isReserved) {
        // Handling booked days by the same user
        final currentUser = day.user!;
        int end = start;

        // Collect consecutive days booked by the same user
        while (end < weekDays && getDay(end + 1).user == currentUser) {
          end++;
        }

        // Determine hasPrevious
        bool hasPrevious = false;
        if (start == 1) {
          final previous =
              _getDate((weekIndex * 7) + 1).subtract(const Duration(days: 1));
          hasPrevious = dayBuilder(previous).user?.id == currentUser.id;
        }

        // Determine hasNext
        bool hasNext = false;
        if (end == weekDays) {
          final next =
              _getDate((weekIndex * 7) + weekDays).add(const Duration(days: 1));
          hasNext = dayBuilder(next).user?.id == currentUser.id;
        }

        // Add the booked day
        result.add((
          user: currentUser,
          start: start,
          end: end,
          hasPrevious: hasPrevious,
          hasNext: hasNext,
        ));

        // Move to the day after the end of the booking
        start = end + 1;
      } else {
        // Handling non-booked days
        int end = start;

        // Collect consecutive non-booked days
        while (end < weekDays && !getDay(end + 1).isReserved) {
          end++;
        }

        // Add non-booked days as one entry
        result.add((
          start: start,
          end: end,
          user: null,
          hasPrevious: null,
          hasNext: null,
        ));

        // Move to the day after the end of non-booked period
        start = end + 1;
      }
    }

    if (weekDays != 7) {
      result.add((
        start: weekDays + 1,
        end: 7,
        user: null,
        hasPrevious: null,
        hasNext: null,
      ));
    }

    return result;
  }

  DateTime _getDate(int day) => DateTime(year, month, day);
}
