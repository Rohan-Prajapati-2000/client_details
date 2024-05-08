import 'package:flutter/material.dart';
import 'package:practice/controller/save_form_data_controller.dart';

class PaymentStatus extends StatefulWidget{


  const PaymentStatus({super.key});

  @override
  State<PaymentStatus> createState() => _PaymentStatusState();
}

class _PaymentStatusState extends State<PaymentStatus> {
  final _list = ['Payment Mode','Online', 'Cash'];
  String? selectedValue = 'Payment Mode';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        value: selectedValue,
        items: _list.map((String value){
          return DropdownMenuItem(
            value: value,
            child: Text(value),
            onTap: (){
              if(selectedValue == null || selectedValue == _list.first){
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
            SaveFromDataController.instance.paymentMethod = newValue;
          });
      },
    );
  }
}