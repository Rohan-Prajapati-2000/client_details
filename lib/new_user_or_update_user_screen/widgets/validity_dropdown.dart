import 'package:flutter/material.dart';

class ValidityDropDown extends StatefulWidget{


  ValidityDropDown({super.key});

  @override
  State<ValidityDropDown> createState() => _ValidityDropDownState();
}

class _ValidityDropDownState extends State<ValidityDropDown> {
  final _list = ['','1 Month', '2 Months', '3 Months', '6 Months' , '1 Year'];

  String? selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        value: selectedValue,
        items: _list.map(
                (e) => DropdownMenuItem(child: Text(e), value: e,)
        ).toList(),
        onChanged: (val){
          setState(() {
            selectedValue = val;
          });
        }
    );
  }
}