import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpiredAndPendingDropdownButton extends StatefulWidget{


  ExpiredAndPendingDropdownButton({super.key});

  @override
  State<ExpiredAndPendingDropdownButton> createState() => _ExpiredAndPendingDropdownButtonState();
}

class _ExpiredAndPendingDropdownButtonState extends State<ExpiredAndPendingDropdownButton> {
  final _years = ['Expired/Pending', 'Expired', 'Pending'];

  String? selectedValue = 'Expired/Pending';

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