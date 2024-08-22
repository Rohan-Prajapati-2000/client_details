import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice/new_user_or_update_user_screen/widgets/renew_new.dart';
import 'package:practice/new_user_or_update_user_screen/widgets/self_tally.dart';
import 'package:practice/utils/constants/sizes.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:practice/utils/validators/validator.dart';

import 'controller/save_form_data_controller.dart';
import 'widgets/image_picker.dart';
import 'widgets/payment_method.dart';
import 'widgets/price_details_menu.dart';

class NewUser extends StatefulWidget {
  const NewUser({super.key});

  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  final controller = Get.put(SaveFromDataController());
  final FocusNode companyNameFocusNode = FocusNode();

  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    // Check if a date is picked
    if (pickedDate != null) {
      // Update the text of the date controller with the picked date
      setState(() {
        Get.find<SaveFromDataController>().date.text =
            pickedDate.toString().split(' ')[0];
      });
    }
  }

  Future<List<Map<String, dynamic>>> fetchCompanySuggestions(String query) async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('client_details')
        .where('Company Name', isGreaterThanOrEqualTo: query)
        .where('Company Name', isLessThanOrEqualTo: query + '\uf8ff')
    .get();
    return querySnapshot.docs.map((doc)=> doc.data() as Map<String, dynamic>).toList();
  }

  void fillCompanyDetails(Map<String, dynamic> companyData){
    controller.companyName.text = companyData['Company Name'] ?? '';
    controller.gstNumber.text = companyData['GST No'] ?? '';
    controller.address.text = companyData['Address'] ?? '';
    controller.contactPerson.text = companyData['Contact Person'] ?? '';
    controller.contactEmail.text = companyData['Contact Email'] ?? '';
    controller.contactNumber.text = companyData['Contact Number'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Form(
            key: controller.userDetailFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  width: 150,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    onPressed: () => Get.back(),
                    child: Text('Back',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: Colors.orange)),
                  ),
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.date,
                        decoration: const InputDecoration(
                          labelText: 'Date',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: selectDate,
                      ),
                    ),
                    const SizedBox(width: SSizes.spaceBtwItems / 2),
                    Expanded(
                      child: RenewNew(),
                    ),
                    Expanded(flex: 6, child: Container()),
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
                Obx((){
                  return Column(
                    children: [
                      TextFormField(
                        controller: controller.companyName,
                        focusNode: companyNameFocusNode,
                        validator: (value)=>  SValidator.validateEmptyText("Company Name", value),
                        decoration: InputDecoration(
                          labelText: 'Company Name'
                        ),
                        onChanged: (value){
                          controller.searchCompanyNames(value);
                        },
                      ),
                      if(controller.companyNameSuggestions.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                            itemCount: controller.companyNameSuggestions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(controller.companyNameSuggestions[index]),
                                onTap: (){
                                  final selectedCompanyName = controller.companyNameSuggestions[index];
                                  controller.companyName.text = selectedCompanyName;
                                  controller.fillCompanyDetails(selectedCompanyName);
                                  controller.companyNameSuggestions.clear();
                                  FocusScope.of(context).requestFocus(FocusNode());
                                }
                              );
                            },
                        )
                    ],
                  );
                }),
                const SizedBox(height: SSizes.spaceBtwItems),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.gstNumber,
                        validator: (value)=>  SValidator.validateEmptyText("GST Number", value),
                        decoration:
                            const InputDecoration(labelText: 'GST Number'),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.address,
                        validator: (value)=>  SValidator.validateEmptyText("Address", value),
                        decoration: const InputDecoration(labelText: 'Address'),
                      ),
                    ),
                    Expanded(flex: 2, child: Container()),
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.contactPerson,
                        validator: (value)=>  SValidator.validateEmptyText("Contact Person Name", value),
                        decoration:
                            const InputDecoration(labelText: 'Contact Person'),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.contactNumber,
                        validator: (value)=>  SValidator.validateEmptyText("Contact Number", value),
                        decoration:
                            const InputDecoration(labelText: 'Contact Number'),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.contactEmail,
                        validator: (value)=>  SValidator.validateEmptyText("Contact Email", value),
                        decoration:
                            const InputDecoration(labelText: 'Contact Email'),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
                Row(
                  children: [
                    Expanded(child: SelfTally()),
                    Expanded(flex: 7, child: Container()),
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
                PriceDetailsMenu(),
                const SizedBox(height: SSizes.spaceBtwItems),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.totalAmount,
                        decoration:
                            const InputDecoration(labelText: 'Total Amount'),
                        readOnly: true, // Making the field read-only
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.receivedAmount,
                        validator: (value)=>  SValidator.validateEmptyText("Received Amount", value),
                        decoration:
                            const InputDecoration(labelText: 'Received Amount'),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
                Row(
                  children: [
                    const Expanded(child: PaymentStatus()),
                    const SizedBox(width: SSizes.spaceBtwItems / 2),
                    Expanded(
                      child: TextFormField(
                        controller: controller.bdmName,
                        validator: (value)=>  SValidator.validateEmptyText("BDM Name", value),
                        decoration:
                            const InputDecoration(labelText: 'BDM Name'),
                      ),
                    ),
                    Expanded(flex: 6, child: Container()),
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.remark,
                        validator: (value)=>  SValidator.validateEmptyText("Remark", value),
                        decoration: const InputDecoration(labelText: 'Remark'),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
                ImagePickerWidget(
                  onImageSelected: (List<Uint8List?> imageBytesList) {
                    Get.find<SaveFromDataController>().selectedImageBytesList =
                        imageBytesList;
                  },
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          width: 1,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    onPressed: () {
                      controller.clearFormFields();
                    },
                    child: Text('Clear Form',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: Colors.red)),
                  ),
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                width: 1,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if(controller.userDetailFormKey.currentState!.validate()){
                              await controller.saveSubscriptions();
                            }
                          },
                          child: Text('Submit',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .apply(color: Colors.green)),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
