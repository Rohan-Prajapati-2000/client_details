import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice/new_user_or_update_user_screen/widgets/renew_new.dart';
import 'package:practice/new_user_or_update_user_screen/widgets/self_tally.dart';
import 'package:practice/utils/constants/sizes.dart';

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
  bool _isLoading = false;

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

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SaveFromDataController());
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
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.companyName,
                        decoration:
                            const InputDecoration(labelText: 'Company Name'),
                      ),
                    ),
                    Expanded(flex: 3, child: Container()),
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.gstNumber,
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
                            await controller.saveSubscriptions();
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
