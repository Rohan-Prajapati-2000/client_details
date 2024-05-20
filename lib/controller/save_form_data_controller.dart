import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:practice/utils/popups/loaders.dart';

import '../model/subscription_model.dart';

class SaveFromDataController extends GetxController {
  static SaveFromDataController get instance => Get.find();

  /// Variable
  final date = TextEditingController();
  final companyName = TextEditingController();
  final gstNumber = TextEditingController();
  final address = TextEditingController();
  final contactPerson = TextEditingController();
  final contactNumber = TextEditingController();
  final contactEmail = TextEditingController();
  final totalAmount = TextEditingController();
  final receivedAmount = TextEditingController();
  final bdmName = TextEditingController();
  final remark = TextEditingController();
  GlobalKey<FormState> userDetailFormKey = GlobalKey<FormState>();
  String? selectedRenewType;
  String? mainType;
  String? paymentMethod;

  final subscriptions = <SubscriptionModel>[].obs;

  void addSubscription(SubscriptionModel subscription) {
    subscriptions.add(subscription);
  }

  Future<void> saveFormDataToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    try {
      await firebaseFirestore.collection('client_details').add({
        'Date': date.text.trim(),
        'Company Name': companyName.text.trim(),
        'GST No': gstNumber.text.trim(),
        'Address': address.text.trim(),
        'Contact Person': contactPerson.text.trim(),
        'Contact Number': contactNumber.text.trim(),
        'Contact Email': contactEmail.text.trim(),
        'Total Amount': totalAmount.text.trim(),
        'Received Amount': receivedAmount.text.trim(),
        'BDM Name': bdmName.text.trim(),
        'Remark': remark.text.trim(),
        'Type': selectedRenewType,
        'Main Type': mainType,
        'Payment Method': paymentMethod,
        'Subscriptions': subscriptions.map((sub) => sub.toJson()).toList(),
      });

      SLoaders.successSnackBar(title: 'Data Saved Successfully');
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Error: $e');
    }
  }
}