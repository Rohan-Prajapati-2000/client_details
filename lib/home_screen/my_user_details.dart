import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'model/user_details_model.dart';

class MyUserDetails extends StatefulWidget {
  @override
  State<MyUserDetails> createState() => _MyUserDetailsState();
}

class _MyUserDetailsState extends State<MyUserDetails> {

  String _calculateBalanceAmount(String totalAmount, String receivedAmount){
    try{
      int total = int.parse(totalAmount);
      int received = int.parse(receivedAmount);
      return (total-received).toString();
    } catch (e){
      return 'Invalid';
    }
  }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('client_details')
          .orderBy('Date')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<MyUserDetailsModel> userDetails = [];
        for (var details in snapshot.data!.docs) {
          userDetails.add(MyUserDetailsModel.fromJson(
              details.data() as Map<String, dynamic>));
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: DataTable(
              columns: [
                DataColumn(label: Text('Sr No')),
                DataColumn(label: Text('Company Name')),
                DataColumn(label: Text('Type')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('GST No')),
                DataColumn(label: Text('Contact Person')),
                DataColumn(label: Text('Contact Number')),
                DataColumn(label: Text('BDM Name')),
                DataColumn(label: Text('Balance Amount')),

              ],
              rows: userDetails
                  .asMap()
                  .entries
                  .map((data) => DataRow(
                        cells: [
                          DataCell(Text('${data.key + 1}')),
                          DataCell(Text(data.value.companyName)),
                          DataCell(Text(data.value.type)),
                          DataCell(Text(data.value.date)),
                          DataCell(Text(data.value.gstNo)),
                          DataCell(Text(data.value.contactPerson)),
                          DataCell(Text(data.value.contactNumber)),
                          DataCell(Text(data.value.bdmName)),
                          DataCell(Text(_calculateBalanceAmount(data.value.totalAmount, data.value.receivedAmount))),
                        ],
                      )).toList(),
            ),
          ),
        );
      },
    );
  }
}
