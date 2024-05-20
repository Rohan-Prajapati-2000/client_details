import 'package:flutter/material.dart';

import '../controller/save_form_data_controller.dart';

class SelfTally extends StatefulWidget {
  SelfTally({super.key});

  @override
  State<SelfTally> createState() => _SelfTallyState();
}

class _SelfTallyState extends State<SelfTally> {
  final _list = ['Self/Tally', 'Self', 'Tally'];
  String? selectedValue = 'Self/Tally';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items: _list.map((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
          onTap: () {
            if (selectedValue == null || selectedValue == _list.first) {
              setState(() {
                selectedValue = null;
              });
            }
          },
        );
      }).toList(),
      onChanged: (String? newValue){
        setState(() {
          selectedValue = newValue;
          SaveFromDataController.instance.mainType = newValue;
        });
      },
    );
  }
}
