import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  Uint8List? selectedImageBytes;
  File? selectedImageFile;

  // Variables for subscription details
  final isCheckedSEO = false.obs;
  final isCheckedVirtualTour = false.obs;
  final isCheckedGBPM = false.obs;
  final isCheckedZKSEO = false.obs;

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

  final subscriptions = <SubscriptionModel>[].obs;

  void addSubscription(SubscriptionModel subscription) {
    subscriptions.add(subscription);
  }

  Future<String?> uploadImageToFirestore() async{
    try{
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child('images/${DateTime.now().millisecondsSinceEpoch}');

      UploadTask uploadTask;

      if(selectedImageBytes != null) {
        uploadTask = imageRef.putData(selectedImageBytes!);
      } else if (selectedImageFile != null){
        uploadTask = imageRef.putFile(selectedImageFile!);
      } else {
        return null;
      }

      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Image upload error: $e');
      return null;
    }

  }


  Future<void> saveFormDataToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    String? imageUrl = await uploadImageToFirestore();

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
        'Image URL': imageUrl,
        'Subscriptions': subscriptions.map((sub) => sub.toJson()).toList(),
      });


      clearFormFields();
      SLoaders.successSnackBar(title: 'Data Saved Successfully');
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Error: $e');
    }
  }

  void saveSubscriptions() {
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
    }
    saveFormDataToFirestore();
  }

  /// method to clear all fields
  void clearFormFields(){
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
    subscriptions.clear();
    selectedImageFile=null;
    selectedImageBytes=null;
  }


}
