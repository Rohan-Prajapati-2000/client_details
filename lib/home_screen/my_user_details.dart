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
  final String companyName;
  final String year;
  final String month;

  const MyUserDetails(
      {required this.companyName,
      super.key,
      required this.year,
      required this.month});

  @override
  MyUserDetailsState createState() => MyUserDetailsState();
}

class MyUserDetailsState extends State<MyUserDetails> {
  List<MyUserDetailsModel> _userDetails = [];
  bool _isLoading = true;
  bool _noData = false;

  String _calculateBalanceAmount(String totalAmount, String receivedAmount,
      [String? balancePaymentAmount]) {
    try {
      if (totalAmount.isEmpty || receivedAmount.isEmpty) {
        return 'Invalid';
      }

      double total = double.parse(totalAmount);
      double received = double.parse(receivedAmount);
      double balancePayment =
          balancePaymentAmount != null && balancePaymentAmount.isNotEmpty
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

  void fetchUserDetails() async {
    setState(() {
      _isLoading = true;
      _noData = false;
    });

    Query query =
        FirebaseFirestore.instance.collection('client_details').orderBy('Date');

    if (widget.companyName.isNotEmpty) {
      query = query.where('Company Name', isEqualTo: widget.companyName);
    }

    if (widget.year.isNotEmpty && widget.year != 'Select Year') {
      query = query.where('Date', isGreaterThanOrEqualTo: '${widget.year}-01-01')
          .where('Date', isLessThanOrEqualTo: '${widget.year}-12-31');
    }

    // if (widget.year.isNotEmpty && widget.year != 'Select Year') {
    //   String monthNumber = '01';
    //   if (widget.month.isNotEmpty && widget.month != 'Select Month') {
    //     final monthIndex = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'].indexOf(widget.month);
    //     if(monthIndex != -1){
    //       monthNumber = (monthIndex+1).toString().padLeft(2, '0');
    //     }
    //   }
    //   String startDate = '${widget.year}-$monthNumber-01';
    //   String endDate = '${widget.year}-$monthNumber-31';
    //   query = query
    //       .where('Date', isGreaterThanOrEqualTo: startDate)
    //       .where('Date', isLessThanOrEqualTo: endDate);
    // }

    query.snapshots().listen((QuerySnapshot snapshot) {
      List<MyUserDetailsModel> userDetails = snapshot.docs
          .map((doc) =>
              MyUserDetailsModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      setState(() {
        _userDetails = userDetails;
        _isLoading = false;
        _noData = userDetails.isEmpty;
      });
    });
  }

  @override
  void didUpdateWidget(covariant MyUserDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.companyName != widget.companyName ||
        oldWidget.year != widget.year ||
        oldWidget.month != widget.month) {
      fetchUserDetails();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_noData) {
      return const Center(child: Text('No Data Available'));
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
            DataColumn(label: Text('Images')),
          ],
          rows: _userDetails.asMap().entries.map((data) {
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
                      Text(_calculateBalanceAmount(user.totalAmount,
                          user.receivedAmount, user.balancePaymentAmount)),
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
                  (user.balancePaymentAmount == null ||
                          user.balancePaymentAmount == '0')
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
                              onTap: () => Get.to(() =>
                                  FullImageViewer(imageList: user.imageList)),
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: Builder(
                                  builder: (context) {
                                    String firstImageBase64 =
                                        user.imageList.first;
                                    Uint8List? imageBytes =
                                        decodeBase64(firstImageBase64);
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
  }
}
