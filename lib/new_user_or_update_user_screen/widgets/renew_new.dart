import 'package:flutter/material.dart';

import '../controller/save_form_data_controller.dart';

class RenewNew extends StatefulWidget{
  RenewNew({super.key});


  @override
  State<RenewNew> createState() => _RenewNewState();
}

class _RenewNewState extends State<RenewNew> {
  final _list = ['New/Renew', 'New', 'Renew'];
  String? selectedValue = 'New/Renew';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items: _list.map((String value){
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          onTap: (){
            if (selectedValue == null || selectedValue == _list.first){
              setState(() {
                selectedValue = null;
              });
            }
          },
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue;
          SaveFromDataController.instance.selectedRenewType = newValue;
        });
      },
    );
  }
}