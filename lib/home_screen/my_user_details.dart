import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice/home_screen/full_image.dart';
import 'package:practice/utils/constants/sizes.dart';
import 'package:practice/utils/popups/loaders.dart';

import '../new_user_or_update_user_screen/widgets/ImageEditingDialog.dart';
import 'model/user_details_model.dart';

class MyUserDetails extends StatefulWidget {
  const MyUserDetails({super.key});

  @override
  State<MyUserDetails> createState() => _MyUserDetailsState();
}

class _MyUserDetailsState extends State<MyUserDetails> {

  String _calculateBalanceAmount(String totalAmount, String receivedAmount, [String? balancePaymentAmount]) {
    try {
      if (totalAmount.isEmpty || receivedAmount.isEmpty) {
        return 'Invalid';
      }

      double total = double.parse(totalAmount);
      double received = double.parse(receivedAmount);
      double balancePayment = balancePaymentAmount != null && balancePaymentAmount.isNotEmpty
          ? double.parse(balancePaymentAmount)
          : 0;

      return (total - received - balancePayment).toStringAsFixed(2);
    } catch (e) {
      return 'Invalid';
    }
  }




  Uint8List? decodeBase64(String? base64String) {
    if (base64String != null && base64String.isNotEmpty) {
      try {
        return base64Decode(base64String);
      } catch (e) {
        SLoaders.errorSnackBar(title: 'Failed to decode base64 string: $e');
      }
    }
    return null;
  }

  Future<void> _showEditDialog(
      BuildContext context, MyUserDetailsModel user) async {
    TextEditingController paymentController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Amount: ${user.totalAmount}'),
              const SizedBox(height: SSizes.spaceBtwItems / 2),
              Text(
                  'Balance Amount: ${_calculateBalanceAmount(user.totalAmount, user.receivedAmount, user.balancePaymentAmount)}'),
              const SizedBox(height: SSizes.spaceBtwItems / 2),
              TextField(
                controller: paymentController,
                decoration: const InputDecoration(labelText: 'Enter Amount'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: SSizes.spaceBtwItems / 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != selectedDate) {
                      selectedDate = picked;
                    }
                  },
                  child: const Text('Select Date'),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  int paymentAmount = int.parse(paymentController.text);
                  String formattedDate =
                      "${selectedDate.toLocal()}".split(' ')[0];
                  await FirebaseFirestore.instance
                      .collection('client_details')
                      .doc(user.srNo)
                      .update({
                    'Balance Payment Amount': paymentAmount.toString(),
                    'Balance Payment Date': formattedDate,
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  SLoaders.errorSnackBar(title: 'Error updating payment: $e');
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('client_details').orderBy('Date').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<MyUserDetailsModel> userDetails = [];
        for (var details in snapshot.data!.docs) {
          userDetails.add(MyUserDetailsModel.fromJson(details.data() as Map<String, dynamic>));
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Sr No')),
                DataColumn(label: Text('Company Name')),
                DataColumn(label: Text('Type')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('GST No')),
                DataColumn(label: Text('Contact Person')),
                DataColumn(label: Text('Contact Number')),
                DataColumn(label: Text('BDM Name')),
                DataColumn(label: Text('Balance Amount')),
                DataColumn(label: Text('Balance Payment')),
                DataColumn(label: Text('Images'))
              ],
              rows: userDetails.asMap().entries.map((data) {
                final user = data.value;

                return DataRow(
                  cells: [
                    DataCell(Text('${data.key + 1}')),
                    DataCell(Text(user.companyName)),
                    DataCell(Text(user.type)),
                    DataCell(Text(user.date)),
                    DataCell(Text(user.gstNo)),
                    DataCell(Text(user.contactPerson)),
                    DataCell(Text(user.contactNumber)),
                    DataCell(Text(user.bdmName)),

                    /// Balance Amount
                    DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_calculateBalanceAmount(user.totalAmount, user.receivedAmount, user.balancePaymentAmount)),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _showEditDialog(context, user);
                            },
                          ),
                        ],
                      ),
                    ),

                    /// Balance Payment
                    DataCell(Text(
                      (user.balancePaymentAmount == null || user.balancePaymentAmount == '0')
                          ? '0'
                          : '${user.balancePaymentAmount} on ${user.balancePaymentDate ?? ''}',
                    )),

                    /// Invoice Images
                    DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          user.imageList.isNotEmpty
                              ? GestureDetector(
                            onTap: () => Get.to(() => FullImageViewer(imageList: user.imageList)),
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Builder(
                                builder: (context) {
                                  String firstImageBase64 = user.imageList.first;
                                  Uint8List? imageBytes = decodeBase64(firstImageBase64);
                                  if (imageBytes != null) {
                                    return Image.memory(
                                      imageBytes,
                                      fit: BoxFit.cover,
                                    );
                                  } else {
                                    return const Text('Invalid Image');
                                  }
                                },
                              ),
                            ),
                          )
                              : const Text('No Image'),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => EditImagesDialog(
                                  initialImages: user.imageList,
                                  documentId: user.srNo,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
