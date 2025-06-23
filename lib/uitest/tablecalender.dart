import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riyadh Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const CalendarScreen(),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final List<String> _periodOptions = ['Daily', 'Weekly', 'Monthly'];
  int _selectedPeriodIndex = 2; // Monthly selected by default
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  final DateTime _currentMonth = DateTime(2025, 6, 1);
  final List<String> _weekDays = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat'
  ];

  String get _dateRangeText {
    if (_rangeStart == null) return 'Select dates';

    final startFormat = DateFormat('MMM d');
    final endFormat = DateFormat('MMM d, yyyy');

    if (_rangeEnd == null || isSameDay(_rangeStart, _rangeEnd)) {
      return startFormat.format(_rangeStart!);
    } else {
      return '${startFormat.format(_rangeStart!)} - ${endFormat.format(_rangeEnd!)}';
    }
  }

  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void _updatePeriodBasedOnDays(int days) {
    if (days < 2) {
      setState(() => _selectedPeriodIndex = 0); // Daily
    } else if (days >= 2 && days <= 7) {
      setState(() => _selectedPeriodIndex = 1); // Weekly
    } else {
      setState(() => _selectedPeriodIndex = 2); // Monthly
    }
  }

  void _selectDate(DateTime day) {
    setState(() {
      if (_selectedPeriodIndex == 0) {
        // Daily
        _rangeStart = day;
        _rangeEnd = day;
      } else {
        if (_rangeStart == null) {
          _rangeStart = day;
        } else if (_rangeEnd == null && !day.isBefore(_rangeStart!)) {
          _rangeEnd = day;
          final days = _rangeEnd!.difference(_rangeStart!).inDays + 1;
          _updatePeriodBasedOnDays(days);
        } else {
          _rangeStart = day;
          _rangeEnd = null;
        }
      }
    });
  }

  void _resetSelection() {
    setState(() {
      _rangeStart = null;
      _rangeEnd = null;
      _selectedPeriodIndex = 2;
    });
  }

  bool _isInRange(DateTime day) {
    if (_rangeStart == null || _rangeEnd == null) return false;
    return (day.isAfter(_rangeStart!) && day.isBefore(_rangeEnd!)) ||
        isSameDay(day, _rangeStart!) ||
        isSameDay(day, _rangeEnd!);
  }

  bool _isStart(DateTime day) {
    return _rangeStart != null && isSameDay(day, _rangeStart!);
  }

  bool _isEnd(DateTime day) {
    return _rangeEnd != null && isSameDay(day, _rangeEnd!);
  }

  List<DateTime> _getDaysInMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);
    final daysInMonth = lastDay.day;

    // Get weekday for the first day (0 = Sunday, 6 = Saturday)
    int firstWeekday = firstDay.weekday % 7; // Adjust to 0-indexed Sunday

    List<DateTime> days = [];

    // Add leading empty days if needed
    for (int i = 0; i < firstWeekday; i++) {
      days.add(DateTime(firstDay.year, firstDay.month, 0 - i));
    }

    // Add actual days of the month
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(month.year, month.month, i));
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _getDaysInMonth(_currentMonth);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Where are you travelling to?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Subheader
              const Text(
                'Choose Dates',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.blue, size: 20),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Riyadh - Apartments, Studios, rooms, Villas, Farms',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Period Selector
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: List.generate(
                    _periodOptions.length,
                    (index) => Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => _selectedPeriodIndex = index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _selectedPeriodIndex == index
                                ? Colors.blue
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              _periodOptions[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _selectedPeriodIndex == index
                                    ? Colors.white
                                    : Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Selected Date Range
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 20, color: Colors.blue[700]),
                    const SizedBox(width: 8),
                    Text(
                      _dateRangeText,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Month Header
              Center(
                child: Text(
                  DateFormat('MMMM yyyy').format(_currentMonth),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Week Days Header
              Row(
                children: _weekDays
                    .map((day) => Expanded(
                          child: Center(
                            child: Text(
                              day,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: day == 'Sun' || day == 'Sat'
                                    ? Colors.red[400]
                                    : Colors.grey[700],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 8),

              // Calendar Grid
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: daysInMonth.length,
                  itemBuilder: (context, index) {
                    final day = daysInMonth[index];
                    final isCurrentMonth = day.month == _currentMonth.month;
                    final isSelected = _isInRange(day);
                    final isStart = _isStart(day);
                    final isEnd = _isEnd(day);
                    final isWeekend = day.weekday == DateTime.sunday ||
                        day.weekday == DateTime.saturday;

                    return GestureDetector(
                      onTap: isCurrentMonth ? () => _selectDate(day) : null,
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: isStart || isEnd
                              ? Colors.blue
                              : isSelected
                                  ? Colors.blue.withOpacity(0.2)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: isStart
                                ? const Radius.circular(20)
                                : Radius.zero,
                            bottomLeft: isStart
                                ? const Radius.circular(20)
                                : Radius.zero,
                            topRight:
                                isEnd ? const Radius.circular(20) : Radius.zero,
                            bottomRight:
                                isEnd ? const Radius.circular(20) : Radius.zero,
                          ),
                          shape: isStart && isEnd
                              ? BoxShape.circle
                              : BoxShape.rectangle,
                        ),
                        child: Center(
                          child: Text(
                            day.day.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isCurrentMonth
                                  ? (isStart || isEnd
                                      ? Colors.white
                                      : isWeekend
                                          ? Colors.red[400]
                                          : Colors.grey[800])
                                  : Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _resetSelection,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Colors.blue),
                      ),
                      child: const Text(
                        'Reset',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Search',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
