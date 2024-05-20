import 'package:flutter/material.dart';

class ValidityDropDown extends StatelessWidget {
  final String selectedValue;
  final Function(String) onSelected;

  ValidityDropDown({
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text('Select Validity'),
      value: selectedValue.isEmpty ? null : selectedValue,
      items: <String>['1 month', '3 months', '6 months', '12 months']
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        onSelected(value!);
      },
    );
  }
}
