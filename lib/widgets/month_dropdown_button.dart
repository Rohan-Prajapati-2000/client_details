import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MonthDropdownButton extends StatefulWidget{


  MonthDropdownButton({super.key});

  @override
  State<MonthDropdownButton> createState() => _MonthDropdownButtonState();
}

class _MonthDropdownButtonState extends State<MonthDropdownButton> {
  final _years = ['Select Month', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August' , 'September', 'October', 'November', 'December'];

  String? selectedValue = 'Select Month';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        value: selectedValue,
        items: _years.map(
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