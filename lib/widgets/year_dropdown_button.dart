import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YearDropdownButton extends StatefulWidget{


  YearDropdownButton({super.key});

  @override
  State<YearDropdownButton> createState() => _YearDropdownButtonState();
}

class _YearDropdownButtonState extends State<YearDropdownButton> {
  final _years = ['Select Year', '2020', '2021', '2022'];

  String? selectedValue = 'Select Year';

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