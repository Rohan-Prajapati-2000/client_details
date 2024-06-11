import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:practice/utils/popups/loaders.dart';

import '../model/subscription_model.dart';

class SaveFromDataController extends GetxController {
  static SaveFromDataController get instance => Get.find();

  // Variables for client details form
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
  List<Uint8List?> selectedImageBytesList = [];

  // Variables for subscription details
  final isCheckedSEO = false.obs;
  final isCheckedVirtualTour = false.obs;
  final isCheckedGBPM = false.obs;
  final isCheckedZKSEO = false.obs;
  final isGoogleAds = false.obs;
  final isGoogleAdsRecharge = false.obs;
  final isFacebook = false.obs;
  final isFacebookRecharge = false.obs;


  final totalAmountSEO = TextEditingController();
  final receivedAmountSEO = TextEditingController();
  final validitySEO = ''.obs;

  final totalAmountVirtualTour = TextEditingController();
  final receivedAmountVirtualTour = TextEditingController();
  final validityVirtualTour = ''.obs;

  final totalAmountGBPM = TextEditingController();
  final receivedAmountGBPM = TextEditingController();
  final validityGBPM = ''.obs;

  final totalAmountZKSEO = TextEditingController();
  final receivedAmountZKSEO = TextEditingController();
  final validityZKSEO = ''.obs;

  final totalAmountisGoogleAds = TextEditingController();
  final receivedAmountisGoogleAds = TextEditingController();
  final validityisGoogleAds = ''.obs;

  final totalAmountisGoogleAdsRecharge = TextEditingController();
  final receivedAmountisGoogleAdsRecharge = TextEditingController();
  final validityisGoogleAdsRecharge = ''.obs;



  final subscriptions = <SubscriptionModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Add listeners to subscription amount controllers
    totalAmountSEO.addListener(calculateTotalAmount);
    totalAmountVirtualTour.addListener(calculateTotalAmount);
    totalAmountGBPM.addListener(calculateTotalAmount);
    totalAmountZKSEO.addListener(calculateTotalAmount);

    // Add listeners to the checkboxes
    ever(isCheckedSEO, (_) => calculateTotalAmount());
    ever(isCheckedVirtualTour, (_) => calculateTotalAmount());
    ever(isCheckedGBPM, (_) => calculateTotalAmount());
    ever(isCheckedZKSEO, (_) => calculateTotalAmount());
  }

  void addSubscription(SubscriptionModel subscription) {
    subscriptions.add(subscription);
    calculateTotalAmount();
  }

  void removeSubscription(SubscriptionModel subscription) {
    subscriptions.remove(subscription);
    calculateTotalAmount();
  }

  void calculateTotalAmount() {
    double total = 0;

    if (isCheckedSEO.value) {
      total += double.tryParse(totalAmountSEO.text) ?? 0;
    }
    if (isCheckedVirtualTour.value) {
      total += double.tryParse(totalAmountVirtualTour.text) ?? 0;
    }
    if (isCheckedGBPM.value) {
      total += double.tryParse(totalAmountGBPM.text) ?? 0;
    }
    if (isCheckedZKSEO.value) {
      total += double.tryParse(totalAmountZKSEO.text) ?? 0;
    }

    totalAmount.text = total.toStringAsFixed(2);
  }

  Future<List<String>?> uploadImageToFirestore() async {
    try {
      if (selectedImageBytesList.isNotEmpty) {
        List<String> base64Images = selectedImageBytesList
            .where((image) => image != null)
            .map((image) => base64Encode(image!))
            .toList();
        return base64Images;
      } else {
        return null;
      }
    } catch (e) {
      // Handle error
      SLoaders.errorSnackBar(title: 'Image upload error: $e');
      return null;
    }
  }

  Future<int> _fetchHighestSrNo() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('client_details')
        .orderBy('Sr No', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return int.parse(snapshot.docs.first['Sr No']);
    } else {
      return 0;
    }
  }

  Future<void> saveFormDataToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    List<String>? imageBase64List = await uploadImageToFirestore();

    try {
      int highestSrNo = await _fetchHighestSrNo();
      int newSrNo = highestSrNo + 1;

      await firebaseFirestore.collection('client_details').doc(newSrNo.toString()).set({
        'Sr No': newSrNo.toString(),
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
        'Image URL': imageBase64List,
        'Subscriptions': subscriptions.map((sub) => sub.toJson()).toList(),
      });

      clearFormFields();
      SLoaders.successSnackBar(title: 'Data Saved Successfully');
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Error: $e');
    }
  }


  Future<void> saveSubscriptions() async{
    if (isCheckedSEO.value) {
      addSubscription(
        SubscriptionModel(
          isSelected: true,
          productTitle: 'Local Keyword SEO',
          validity: validitySEO.value,
          productTotalAmount: totalAmountSEO.text,
          productBalanceAmount: receivedAmountSEO.text,
        ),
      );
    } else {
      removeSubscription(SubscriptionModel(
        isSelected: true,
        productTitle: 'Local Keyword SEO',
        validity: validitySEO.value,
        productTotalAmount: totalAmountSEO.text,
        productBalanceAmount: receivedAmountSEO.text,
      ));
    }

    if (isCheckedVirtualTour.value) {
      addSubscription(
        SubscriptionModel(
          isSelected: true,
          productTitle: 'Virtual Tour',
          validity: validityVirtualTour.value,
          productTotalAmount: totalAmountVirtualTour.text,
          productBalanceAmount: receivedAmountVirtualTour.text,
        ),
      );
    } else {
      removeSubscription(SubscriptionModel(
        isSelected: true,
        productTitle: 'Virtual Tour',
        validity: validityVirtualTour.value,
        productTotalAmount: totalAmountVirtualTour.text,
        productBalanceAmount: receivedAmountVirtualTour.text,
      ));
    }

    if (isCheckedGBPM.value) {
      addSubscription(
        SubscriptionModel(
          isSelected: true,
          productTitle: 'Google Business Profile Management',
          validity: validityGBPM.value,
          productTotalAmount: totalAmountGBPM.text,
          productBalanceAmount: receivedAmountGBPM.text,
        ),
      );
    } else {
      removeSubscription(SubscriptionModel(
        isSelected: true,
        productTitle: 'Google Business Profile Management',
        validity: validityGBPM.value,
        productTotalAmount: totalAmountGBPM.text,
        productBalanceAmount: receivedAmountGBPM.text,
      ));
    }

    if (isCheckedZKSEO.value) {
      addSubscription(
        SubscriptionModel(
          isSelected: true,
          productTitle: 'Zonal Keyword SEO',
          validity: validityZKSEO.value,
          productTotalAmount: totalAmountZKSEO.text,
          productBalanceAmount: receivedAmountZKSEO.text,
        ),
      );
    } else {
      removeSubscription(SubscriptionModel(
        isSelected: true,
        productTitle: 'Zonal Keyword SEO',
        validity: validityZKSEO.value,
        productTotalAmount: totalAmountZKSEO.text,
        productBalanceAmount: receivedAmountZKSEO.text,
      ));
    }

    saveFormDataToFirestore();
  }

  /// method to clear all fields
  void clearFormFields() {
    date.clear();
    companyName.clear();
    gstNumber.clear();
    address.clear();
    contactPerson.clear();
    contactNumber.clear();
    contactEmail.clear();
    totalAmount.clear();
    receivedAmount.clear();
    bdmName.clear();
    remark.clear();
    isCheckedSEO.value = false;
    isCheckedVirtualTour.value = false;
    isCheckedGBPM.value = false;
    isCheckedZKSEO.value = false;
    totalAmountSEO.clear();
    receivedAmountSEO.clear();
    validitySEO.value = '';
    totalAmountVirtualTour.clear();
    receivedAmountVirtualTour.clear();
    validityVirtualTour.value = '';
    totalAmountGBPM.clear();
    receivedAmountGBPM.clear();
    validityGBPM.value = '';
    totalAmountZKSEO.clear();
    receivedAmountZKSEO.clear();
    validityZKSEO.value = '';
  }
}
