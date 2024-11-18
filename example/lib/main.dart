import 'package:calendar_viewer/calendar_viewer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar Viewer',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const CalendarViewerExample(title: 'Calendar Viewer Example'),
    );
  }
}

class CalendarViewerExample extends StatefulWidget {
  const CalendarViewerExample({super.key, required this.title});

  final String title;

  @override
  State<CalendarViewerExample> createState() => _CalendarViewerExampleState();
}

class _CalendarViewerExampleState extends State<CalendarViewerExample> {
  final _now = DateTime.now();

  late DateTime _selectedDate;

  final _specialDates = [
    DateTime(2020, 1, 11),
    DateTime(2021, 3, 2),
    DateTime(2022, 9, 15),
    DateTime(2023, 10, 7),
    DateTime(2024, 4, 8),
    DateTime(2025, 5, 15),
    DateTime(2026, 10, 20),
    DateTime(2027, 8, 12),
    DateTime(2028, 3, 3),
    DateTime(2029, 7, 18),
    DateTime(2030, 1, 1),
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = _specialDates[3];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Select Special Year !',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButton(
                  isExpanded: false,
                  value: _selectedDate,
                  items: _specialDates
                      .map((date) => DropdownMenuItem(
                            value: date,
                            child: Text('${date.year}'),
                          ))
                      .toList(),
                  onChanged: (date) {
                    setState(() {
                      _selectedDate = date!;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CalendarViewer(
            key: Key(_selectedDate.toString()),
            initialDate: _selectedDate,
            months: const [
              'Jan',
              'Feb',
              'Mar',
              'Apr',
              'May',
              'Jun',
              'Jul',
              'Aug',
              'Sep',
              'Oct',
              'Nov',
              'Dec'
            ],
            weekdays: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            reservation: CalenderReservationConfig(
              style: const CalendarReservationStyle(
                height: 20,
                userImageSize: 14,
                userNameTextStyle: TextStyle(fontSize: 12),
                color: Color.fromARGB(255, 150, 201, 189),
                radius: Radius.circular(20),
                bottomMargin: 4,
                horizontalMargin: 16,
              ),
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
            ),
            dateConfigBuilder: (date) {
              // Return custom style for specific dates
              if (date.isAtSameMomentAs(_selectedDate) ||
                  date.isAtSameMomentAs(
                    DateTime(_now.year, _now.month, _now.day),
                  )) {
                return CalendarDateConfig(
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(.3),
                  ),
                );
              }
              // return null for others to use [dateConfig] as default.
              return null;
            },
            nextMonthDateConfig: CalendarDateConfig(
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.black12, width: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
