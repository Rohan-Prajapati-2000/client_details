import 'package:flutter/material.dart';

class MonthDropdownButton extends StatefulWidget {

  final ValueChanged<String> onMonthChange;

  MonthDropdownButton({super.key, required this.onMonthChange});

  @override
  State<MonthDropdownButton> createState() => _MonthDropdownButtonState();
}

class _MonthDropdownButtonState extends State<MonthDropdownButton> {
  final _months = [
    'Select Month', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'
  ];

  String? selectedValue = 'Select Month';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        value: selectedValue,
        items: _months.map(
                (e) => DropdownMenuItem(value: e, child: Text(e),)
        ).toList(),
        onChanged: (val) {
          setState(() {
            selectedValue = val;
          });
          widget.onMonthChange(val!);
        }
    );
  }
}
