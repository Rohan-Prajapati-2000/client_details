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
  final isCheckedGoogleAds = false.obs;
  final isCheckedGoogleAdsRecharge = false.obs;
  final isCheckedFacebook = false.obs;
  final isCheckedFacebookRecharge = false.obs;
  final isCheckedWebsite = false.obs;
  final isCheckedCustomDevelopment = false.obs;
  final isCheckedWebsiteAmc = false.obs;
  final isCheckedProductPhotography = false.obs;
  final isCheckedDomain = false.obs;
  final isCheckedHosting = false.obs;
  final isCheckedQrCode = false.obs;
  final isCheckedWebSEO = false.obs;
  final isCheckedOthers = false.obs;


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

  final totalAmountGoogleAds = TextEditingController();
  final receivedAmountGoogleAds = TextEditingController();
  final validityGoogleAds = ''.obs;

  final totalAmountGoogleAdsRecharge = TextEditingController();
  final receivedAmountGoogleAdsRecharge = TextEditingController();
  final validityGoogleAdsRecharge = ''.obs;

  final totalAmountFacebook = TextEditingController();
  final receivedAmountFacebook = TextEditingController();
  final validityFacebook = ''.obs;

  final totalAmountFacebookRecharge = TextEditingController();
  final receivedAmountFacebookRecharge = TextEditingController();
  final validityFacebookRecharge= ''.obs;

  final totalAmountWebsite = TextEditingController();
  final receivedAmountWebsite = TextEditingController();
  final validityWebsite = ''.obs;

  final totalAmountCustomDevelopment = TextEditingController();
  final receivedAmountCustomDevelopment = TextEditingController();
  final validityCustomDevelopment = ''.obs;

  final totalAmountWebsiteAmc = TextEditingController();
  final receivedAmountWebsiteAmc = TextEditingController();
  final validityWebsiteAmc = ''.obs;

  final totalAmountProductPhotography = TextEditingController();
  final receivedAmountProductPhotography = TextEditingController();
  final validityProductPhotography = ''.obs;

  final totalAmountDomain = TextEditingController();
  final receivedAmountDomain = TextEditingController();
  final validityDomain = ''.obs;

  final totalAmountHosting = TextEditingController();
  final receivedAmountHosting = TextEditingController();
  final validityHosting = ''.obs;

  final totalAmountQrCode = TextEditingController();
  final receivedAmountQrCode = TextEditingController();
  final validityQrCode = ''.obs;

  final totalAmountWebSEO = TextEditingController();
  final receivedAmountWebSEO = TextEditingController();
  final validityWebSEO = ''.obs;

  final totalAmountOthers = TextEditingController();
  final receivedAmountOthers = TextEditingController();
  final validityOthers = ''.obs;


  final subscriptions = <SubscriptionModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Add listeners to subscription amount controllers
    totalAmountSEO.addListener(calculateTotalAmount);
    totalAmountVirtualTour.addListener(calculateTotalAmount);
    totalAmountGBPM.addListener(calculateTotalAmount);
    totalAmountZKSEO.addListener(calculateTotalAmount);
    totalAmountGoogleAds.addListener(calculateTotalAmount);
    totalAmountGoogleAdsRecharge.addListener(calculateTotalAmount);
    totalAmountFacebook.addListener(calculateTotalAmount);
    totalAmountFacebookRecharge.addListener(calculateTotalAmount);
    totalAmountWebsite.addListener(calculateTotalAmount);
    totalAmountCustomDevelopment.addListener(calculateTotalAmount);
    totalAmountWebsiteAmc.addListener(calculateTotalAmount);
    totalAmountProductPhotography.addListener(calculateTotalAmount);
    totalAmountDomain.addListener(calculateTotalAmount);
    totalAmountHosting.addListener(calculateTotalAmount);
    totalAmountQrCode.addListener(calculateTotalAmount);
    totalAmountWebSEO.addListener(calculateTotalAmount);
    totalAmountOthers.addListener(calculateTotalAmount);

    // Add listeners to the checkboxes
    ever(isCheckedSEO, (_) => calculateTotalAmount());
    ever(isCheckedVirtualTour, (_) => calculateTotalAmount());
    ever(isCheckedGBPM, (_) => calculateTotalAmount());
    ever(isCheckedZKSEO, (_) => calculateTotalAmount());
    ever(isCheckedGoogleAds, (_) => calculateTotalAmount());
    ever(isCheckedGoogleAdsRecharge, (_) => calculateTotalAmount());
    ever(isCheckedFacebook, (_) => calculateTotalAmount());
    ever(isCheckedFacebookRecharge, (_) => calculateTotalAmount());
    ever(isCheckedWebsite, (_) => calculateTotalAmount());
    ever(isCheckedCustomDevelopment, (_) => calculateTotalAmount());
    ever(isCheckedWebsiteAmc, (_) => calculateTotalAmount());
    ever(isCheckedProductPhotography, (_) => calculateTotalAmount());
    ever(isCheckedDomain, (_) => calculateTotalAmount());
    ever(isCheckedHosting, (_) => calculateTotalAmount());
    ever(isCheckedQrCode, (_) => calculateTotalAmount());
    ever(isCheckedWebSEO, (_) => calculateTotalAmount());
    ever(isCheckedOthers, (_) => calculateTotalAmount());
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
    if (isCheckedGoogleAds.value) {
      total += double.tryParse(totalAmountZKSEO.text) ?? 0;
    }if (isCheckedGoogleAdsRecharge.value) {
      total += double.tryParse(totalAmountZKSEO.text) ?? 0;
    }if (isCheckedFacebook.value) {
      total += double.tryParse(totalAmountZKSEO.text) ?? 0;
    }if (isCheckedFacebookRecharge.value) {
      total += double.tryParse(totalAmountZKSEO.text) ?? 0;
    }if (isCheckedWebsite.value) {
      total += double.tryParse(totalAmountZKSEO.text) ?? 0;
    }if (isCheckedCustomDevelopment.value) {
      total += double.tryParse(totalAmountZKSEO.text) ?? 0;
    }if (isCheckedWebsiteAmc.value) {
      total += double.tryParse(totalAmountZKSEO.text) ?? 0;
    }if (isCheckedProductPhotography.value) {
      total += double.tryParse(totalAmountZKSEO.text) ?? 0;
    }if (isCheckedDomain.value) {
      total += double.tryParse(totalAmountZKSEO.text) ?? 0;
    }if (isCheckedHosting.value) {
      total += double.tryParse(totalAmountZKSEO.text) ?? 0;
    }if (isCheckedQrCode.value) {
      total += double.tryParse(totalAmountZKSEO.text) ?? 0;
    }if (isCheckedWebSEO.value) {
      total += double.tryParse(totalAmountZKSEO.text) ?? 0;
    }if (isCheckedOthers.value) {
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
    if (isCheckedGoogleAds.value) {
      addSubscription(
        SubscriptionModel(
          isSelected: true,
          productTitle: 'Google Ads',
          validity: validityGoogleAds.value,
          productTotalAmount: totalAmountGoogleAds.text,
          productBalanceAmount: receivedAmountGoogleAds.text,
        ),
      );
    } else {
      removeSubscription(SubscriptionModel(
        isSelected: true,
        productTitle: 'Google Ads',
        validity: validityGoogleAds.value,
        productTotalAmount: totalAmountGoogleAds.text,
        productBalanceAmount: receivedAmountGoogleAds.text,
      ));
    }
    if (isCheckedGoogleAdsRecharge.value) {
      addSubscription(
        SubscriptionModel(
          isSelected: true,
          productTitle: "Google Ads Recharge",
          validity: validityGoogleAdsRecharge.value,
          productTotalAmount: totalAmountGoogleAdsRecharge.text,
          productBalanceAmount: receivedAmountGoogleAdsRecharge.text,
        ),
      );
    } else {
      removeSubscription(SubscriptionModel(
        isSelected: true,
        productTitle: "Google Ads Recharge",
        validity: validityGoogleAdsRecharge.value,
        productTotalAmount: totalAmountGoogleAdsRecharge.text,
        productBalanceAmount: receivedAmountGoogleAdsRecharge.text,
      ));
    }
    if (isCheckedFacebook.value) {
      addSubscription(
        SubscriptionModel(
          isSelected: true,
          productTitle: "Facebook",
          validity: validityFacebook.value,
          productTotalAmount: totalAmountFacebook.text,
          productBalanceAmount: receivedAmountFacebook.text,
        ),
      );
    } else {
      removeSubscription(SubscriptionModel(
        isSelected: true,
        productTitle: "Facebook",
        validity: validityFacebook.value,
        productTotalAmount: totalAmountFacebook.text,
        productBalanceAmount: receivedAmountFacebook.text,
      ));
    }
    if (isCheckedFacebookRecharge.value) {
      addSubscription(
        SubscriptionModel(
          isSelected: true,
          productTitle: "Facebook Ads Recharge",
          validity: validityFacebookRecharge.value,
          productTotalAmount: totalAmountFacebookRecharge.text,
          productBalanceAmount: receivedAmountFacebookRecharge.text,
        ),
      );
    } else {
      removeSubscription(SubscriptionModel(
        isSelected: true,
        productTitle: "Facebook Ads Recharge",
        validity: validityFacebookRecharge.value,
        productTotalAmount: totalAmountFacebookRecharge.text,
        productBalanceAmount: receivedAmountFacebookRecharge.text,
      ));
    }
    if (isCheckedWebsite.value) {
      addSubscription(
        SubscriptionModel(
          isSelected: true,
          productTitle: "Website",
          validity: validityWebsite.value,
          productTotalAmount: totalAmountWebsite.text,
          productBalanceAmount: receivedAmountWebsite.text,
        ),
      );
    } else {
      removeSubscription(SubscriptionModel(
        isSelected: true,
        productTitle: "Website",
        validity: validityWebsite.value,
        productTotalAmount: totalAmountWebsite.text,
        productBalanceAmount: receivedAmountWebsite.text,
      ));
    }
    if (isCheckedCustomDevelopment.value) {
      addSubscription(
        SubscriptionModel(
          isSelected: true,
          productTitle: "Custom Development",
          validity: validityCustomDevelopment.value,
          productTotalAmount: totalAmountCustomDevelopment.text,
          productBalanceAmount: receivedAmountCustomDevelopment.text,
        ),
      );
    } else {
      removeSubscription(SubscriptionModel(
        isSelected: true,
        productTitle: "Custom Development",
        validity: validityCustomDevelopment.value,
        productTotalAmount: totalAmountCustomDevelopment.text,
        productBalanceAmount: receivedAmountCustomDevelopment.text,
      ));
    }
    if (isCheckedWebsiteAmc.value) {
      addSubscription(
        SubscriptionModel(
          isSelected: true,
          productTitle: "Website Amc",
          validity: validityWebsiteAmc.value,
          productTotalAmount: totalAmountWebsiteAmc.text,
          productBalanceAmount: receivedAmountWebsiteAmc.text,
        ),
      );
    } else {
      removeSubscription(SubscriptionModel(
        isSelected: true,
        productTitle: "Website Amc",
        validity: validityWebsiteAmc.value,
        productTotalAmount: totalAmountWebsiteAmc.text,
        productBalanceAmount: receivedAmountWebsiteAmc.text,
      ));
    }
    if (isCheckedProductPhotography.value) {
      addSubscription(
        SubscriptionModel(
          isSelected: true,
          productTitle: "Product Photography",
          validity: validityProductPhotography.value,
          productTotalAmount: totalAmountProductPhotography.text,
          productBalanceAmount: receivedAmountProductPhotography.text,
        ),
      );
    } else {
      removeSubscription(SubscriptionModel(
        isSelected: true,
        productTitle: "Product Photography",
        validity: validityProductPhotography.value,
        productTotalAmount: totalAmountProductPhotography.text,
        productBalanceAmount: receivedAmountProductPhotography.text,
      ));
    }
    if (isCheckedDomain.value) {
      addSubscription(
        SubscriptionModel(
          isSelected: true,
          productTitle: "Domain",
          validity: validityDomain.value,
          productTotalAmount: totalAmountDomain.text,
          productBalanceAmount: receivedAmountDomain.text,
        ),
      );
    } else {
      removeSubscription(SubscriptionModel(
        isSelected: true,
        productTitle: "Domain",
        validity: validityDomain.value,
        productTotalAmount: totalAmountDomain.text,
        productBalanceAmount: receivedAmountDomain.text,
      ));
    }
    if (isCheckedHosting.value) {
      addSubscription(
        SubscriptionModel(
          isSelected: true,
          productTitle: "Hosting",
          validity: validityHosting.value,
          productTotalAmount: totalAmountHosting.text,
          productBalanceAmount: receivedAmountHosting.text,
        ),
      );
    } else {
      removeSubscription(SubscriptionModel(
        isSelected: true,
        productTitle: "Hosting",
        validity: validityHosting.value,
        productTotalAmount: totalAmountHosting.text,
        productBalanceAmount: receivedAmountHosting.text,
      ));
    }
    if (isCheckedQrCode.value) {
      addSubscription(
        SubscriptionModel(
          isSelected: true,
          productTitle: "QR Code",
          validity: validityQrCode.value,
          productTotalAmount: totalAmountQrCode.text,
          productBalanceAmount: receivedAmountQrCode.text,
        ),
      );
    } else {
      removeSubscription(SubscriptionModel(
        isSelected: true,
        productTitle: "QR Code",
        validity: validityQrCode.value,
        productTotalAmount: totalAmountQrCode.text,
        productBalanceAmount: receivedAmountQrCode.text,
      ));
    }
    if (isCheckedWebSEO.value) {
      addSubscription(
        SubscriptionModel(
          isSelected: true,
          productTitle: "Web SEO",
          validity: validityWebSEO.value,
          productTotalAmount: totalAmountWebSEO.text,
          productBalanceAmount: receivedAmountWebSEO.text,
        ),
      );
    } else {
      removeSubscription(SubscriptionModel(
        isSelected: true,
        productTitle: "Web SEO",
        validity: validityWebSEO.value,
        productTotalAmount: totalAmountWebSEO.text,
        productBalanceAmount: receivedAmountWebSEO.text,
      ));
    }
    if (isCheckedOthers.value) {
      addSubscription(
        SubscriptionModel(
          isSelected: true,
          productTitle: "Others",
          validity: validityOthers.value,
          productTotalAmount: totalAmountOthers.text,
          productBalanceAmount: receivedAmountOthers.text,
        ),
      );
    } else {
      removeSubscription(SubscriptionModel(
        isSelected: true,
        productTitle: "Others",
        validity: validityOthers.value,
        productTotalAmount: totalAmountOthers.text,
        productBalanceAmount: receivedAmountOthers.text,
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
    isCheckedGoogleAds.value = false;
    isCheckedGoogleAdsRecharge.value = false;
    isCheckedFacebook.value = false;
    isCheckedFacebookRecharge.value = false;
    isCheckedWebsite.value = false;
    isCheckedCustomDevelopment.value = false;
    isCheckedWebsiteAmc.value = false;
    isCheckedProductPhotography.value = false;
    isCheckedDomain.value = false;
    isCheckedHosting.value = false;
    isCheckedQrCode.value = false;
    isCheckedWebSEO.value = false;
    isCheckedOthers.value = false;
    totalAmountSEO.clear();
    totalAmountVirtualTour.clear();
    totalAmountGBPM.clear();
    totalAmountZKSEO.clear();
    totalAmountGoogleAds.clear();
    totalAmountGoogleAdsRecharge.clear();
    totalAmountFacebook.clear();
    totalAmountFacebookRecharge.clear();
    totalAmountWebsite.clear();
    totalAmountCustomDevelopment.clear();
    totalAmountWebsiteAmc.clear();
    totalAmountProductPhotography.clear();
    totalAmountDomain.clear();
    totalAmountHosting.clear();
    totalAmountQrCode.clear();
    totalAmountWebSEO.clear();
    totalAmountOthers.clear();
    receivedAmountSEO.clear();
    receivedAmountGBPM.clear();
    receivedAmountVirtualTour.clear();
    receivedAmountZKSEO.clear();
    receivedAmountGoogleAds.clear();
    receivedAmountGoogleAdsRecharge.clear();
    receivedAmountFacebook.clear();
    receivedAmountFacebookRecharge.clear();
    receivedAmountWebsite.clear();
    receivedAmountCustomDevelopment.clear();
    receivedAmountWebsiteAmc.clear();
    receivedAmountProductPhotography.clear();
    receivedAmountDomain.clear();
    receivedAmountHosting.clear();
    receivedAmountQrCode.clear();
    receivedAmountWebSEO.clear();
    receivedAmountOthers.clear();
    validitySEO.value = '';
    validityVirtualTour.value = '';
    validityGBPM.value = '';
    validityZKSEO.value = '';
    validityGoogleAds.value = '';
    validityGoogleAdsRecharge.value = '';
    validityFacebook.value = '';
    validityFacebookRecharge.value = '';
    validityWebsite.value = '';
    validityCustomDevelopment.value = '';
    validityWebsiteAmc.value = '';
    validityProductPhotography.value = '';
    validityDomain.value = '';
    validityHosting.value = '';
    validityQrCode.value = '';
    validityWebSEO.value = '';
    validityOthers.value = '';
  }
}
