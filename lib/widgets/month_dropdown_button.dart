import 'package:flutter/material.dart';

class MonthDropdownButton extends StatefulWidget {
  final ValueChanged<String> onMonthChange;

  MonthDropdownButton({Key? key, required this.onMonthChange}) : super(key: key);

  @override
  State<MonthDropdownButton> createState() => _MonthDropdownButtonState();
}

class _MonthDropdownButtonState extends State<MonthDropdownButton> {
  final List<String> _months = [
    'Select Month', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'
  ];

  String? _selectedValue = 'Select Month';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedValue,
      items: _months.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (newValue) {
        if (newValue != _selectedValue) { // Check if the value changed
          setState(() {
            _selectedValue = newValue;
          });
          widget.onMonthChange(newValue!);
        }
      },
    );
  }
}
