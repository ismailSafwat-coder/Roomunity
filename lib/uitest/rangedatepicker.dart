import 'package:flutter/material.dart';

class Rangedatepicker extends StatefulWidget {
  const Rangedatepicker({super.key});

  @override
  State<Rangedatepicker> createState() => _RangedatepickerState();
}

class _RangedatepickerState extends State<Rangedatepicker> {
  DateTimeRange daterange =
      DateTimeRange(start: DateTime(2025), end: DateTime(2026));

  @override
  Widget build(BuildContext context) {
    final start = daterange.start;
    final end = daterange.end;
    final duration = daterange.duration;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Date range Picker'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _showDatePicker();
                  },
                  child: Text('${start.year} ${start.month} ${start.day} ')),
              ElevatedButton(
                  onPressed: () {
                    _showDatePicker();
                  },
                  child: Text('${end.year} ${end.month} ${end.day} ')),
            ],
          ),
          Text('Duration: $duration'),
        ],
      ),
    );
  }

  Future<void> _showDatePicker() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2026),
    );
    if (picked != null) {
      setState(() {
        daterange = picked;
      });
    }
    if (picked == null) return;
    setState(() {
      daterange = picked;
    });
  }
}
