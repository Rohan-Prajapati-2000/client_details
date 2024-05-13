import 'package:flutter/material.dart';
import 'package:practice/controller/save_form_data_controller.dart';

class ValidityDropDown extends StatefulWidget {
  const ValidityDropDown({super.key, this.onChanged});
  final ValueSetter<String>? onChanged;

  @override
  State<ValidityDropDown> createState() => _ValidityDropDownState();
}

class _ValidityDropDownState extends State<ValidityDropDown> {
  final List<String> _list = [
    'Select',
    '1 Month',
    '2 Months',
    '3 Months',
    '4 Months',
    '6 Months',
    '1 Year'
  ];

  late String selectedValue;
  @override
  void initState() {
    super.initState();
    selectedValue = _list[0];
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> items = [];
    for (String i in _list) {
      items.add(DropdownMenuItem<String>(
        child: Text(i),
        value: i,
      ));
    }

    return DropdownButtonFormField<String>(
        value: selectedValue,
        hint: const Text('Select Validity'),
        items: items,
        onChanged: (val) {
          setState(() {
            selectedValue = val!;
            if (selectedValue == _list[0]) {
              _list.removeAt(0);
              selectedValue = '';
            }
            widget.onChanged?.call(selectedValue);
            SaveFromDataController.instance.validity = selectedValue;
          });
        });
  }
}
