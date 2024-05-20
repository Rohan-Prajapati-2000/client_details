import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice/new_user_or_update_user_screen/widgets/renew_new.dart';
import 'package:practice/new_user_or_update_user_screen/widgets/self_tally.dart';
import 'package:practice/utils/constants/sizes.dart';

import 'controller/save_form_data_controller.dart';
import 'widgets/payment_method.dart';
import 'widgets/price_details_menu.dart';

class NewUser extends StatefulWidget {
  const NewUser({super.key});

  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {

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
        Get.find<SaveFromDataController>().date.text = pickedDate.toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(SaveFromDataController());
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
                            borderRadius: BorderRadius.circular(10)
                        ),
                        side: BorderSide(
                          color: Colors.orange,
                        )
                    ),
                    onPressed: () => Get.back(),
                    child: Text('Back', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.orange)),
                  ),
                ),

                SizedBox(height: SSizes.spaceBtwItems),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.date,
                        decoration: InputDecoration(
                          labelText: 'Date',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: selectDate,
                      ),
                    ),

                    SizedBox(width: SSizes.spaceBtwItems/2),

                    Expanded(
                      child: RenewNew(),
                    ),

                    Expanded(flex: 6, child: Container())
                  ],
                ),

                SizedBox(height: SSizes.spaceBtwItems),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.companyName,
                        decoration: InputDecoration(
                            labelText: 'Company Name'
                        ),
                      ),
                    ),

                    Expanded(flex: 3, child: Container())
                  ],
                ),

                SizedBox(height: SSizes.spaceBtwItems),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.gstNumber,
                        decoration: InputDecoration(
                            labelText: 'GST Number'
                        ),
                      ),
                    ),

                    Expanded(flex: 4, child: Container())
                  ],
                ),

                SizedBox(height: SSizes.spaceBtwItems),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.address,
                        decoration: InputDecoration(
                            labelText: 'Address'
                        ),
                      ),
                    ),

                    Expanded(flex: 2, child: Container())
                  ],
                ),

                SizedBox(height: SSizes.spaceBtwItems),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.contactPerson,
                        decoration: InputDecoration(
                            labelText: 'Contact Person'
                        ),
                      ),
                    ),

                    Expanded(flex: 4, child: Container())
                  ],
                ),

                SizedBox(height: SSizes.spaceBtwItems),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.contactNumber,
                        decoration: InputDecoration(
                            labelText: 'Contact Number'
                        ),
                      ),
                    ),

                    Expanded(flex: 4, child: Container())
                  ],
                ),

                SizedBox(height: SSizes.spaceBtwItems),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.contactEmail,
                        decoration: InputDecoration(
                            labelText: 'Contact Email'
                        ),
                      ),
                    ),

                    Expanded(flex: 4, child: Container())
                  ],
                ),

                SizedBox(height: SSizes.spaceBtwItems),

                Row(
                  children: [
                    Expanded(child: SelfTally()),
                    Expanded(flex: 7, child: Container())
                  ],
                ),

                SizedBox(height: SSizes.spaceBtwItems),

                PriceDetailsMenu(),

                SizedBox(height: SSizes.spaceBtwItems),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.totalAmount,
                        decoration: InputDecoration(
                            labelText: 'Total Amount'
                        ),
                      ),
                    ),

                    Expanded(flex: 4, child: Container())
                  ],
                ),

                SizedBox(height: SSizes.spaceBtwItems),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.receivedAmount,
                        decoration: InputDecoration(
                            labelText: 'Received Amount'
                        ),
                      ),
                    ),

                    Expanded(flex: 4, child: Container())
                  ],
                ),

                SizedBox(height: SSizes.spaceBtwItems),

                Row(
                  children: [
                    Expanded(child: PaymentStatus()),

                    SizedBox(width: SSizes.spaceBtwItems/2),

                    Expanded(
                      child: TextFormField(
                        controller: controller.bdmName,
                        decoration: InputDecoration(
                            labelText: 'BDM Name'
                        ),
                      ),
                    ),

                    Expanded(flex: 6, child: Container())

                  ],
                ),

                SizedBox(height: SSizes.spaceBtwItems),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.remark,
                        decoration: InputDecoration(
                            labelText: 'Remark'
                        ),
                      ),
                    ),

                    Expanded(child: Container())
                  ],
                ),

                SizedBox(height: SSizes.spaceBtwItems),

                SizedBox(
                  height: 40,
                  width: 150,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  width: 1,
                                  color: Colors.red
                              )
                          )
                      ),
                      onPressed: (){
                        controller.clearFormFields();
                      },
                      child: Text('Clear Form', style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.red))
                  ),
                ),


                SizedBox(height: SSizes.spaceBtwItems),

                SizedBox(
                    height: 40,
                    width: 150,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    width: 1,
                                    color: Colors.green
                                )
                            )
                        ),
                        onPressed: (){
                          controller.saveSubscriptions();
                        },
                        child: Text('Submit', style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.green)))
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}