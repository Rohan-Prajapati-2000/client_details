import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:practice/new_user_or_update_user_screen/new.dart';

import '../my_user_details.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';
import 'button_icon_with_text.dart';
import 'expired_pending_dropdown_button.dart';
import 'month_dropdown_button.dart';
import 'year_dropdown_button.dart';


class MyHomeHeader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            // Profile
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(SSizes.defaultSpace / 2),
                  child: Icon(Icons.account_circle),
                )
              ],
            ),

            // Add New Button
            Container(
              height: 40,
              width: double.infinity,
              color: SColors.secondaryColor,
              child: Row(
                children: [
                  SizedBox(width: SSizes.spaceBtwItems),
                  SizedBox(
                    height: 35,
                    width: 140,
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: SColors.secondaryColor),
                        ),
                      ),
                      onPressed: ()=> Get.to(()=> NewUser()),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultSpace / 2),
                        child: Text(
                          'Add New',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(SSizes.spaceBtwItems / 2),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: SSizes.spaceBtwItems * 2, vertical: SSizes.spaceBtwItems / 1.8),
                      child: Text(
                        'Details',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    Divider(),
                    SizedBox(height: SSizes.spaceBtwItems),
                    Padding(
                      padding: const EdgeInsets.all(SSizes.defaultSpace),
                      child: Column(
                        children: [
                          // FILTER
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(labelText: 'Company Name'),
                                ),
                              ),
                              SizedBox(width: SSizes.spaceBtwItems / 2),
                                Expanded(child: YearDropdownButton()),
                                SizedBox(width: SSizes.spaceBtwItems / 2),
                                Expanded(child: MonthDropdownButton()),
                                SizedBox(width: SSizes.spaceBtwItems / 2),
                                Expanded(child: ExpiredAndPendingDropdownButton()),
                                SizedBox(width: SSizes.spaceBtwItems / 2),
                            ],
                          ),

                          SizedBox(height: SSizes.spaceBtwItems),

                          Row(
                            children: [
                              Expanded(
                                child: ButtonWithIconAndText(
                                  icon: CupertinoIcons.search,
                                  onPressed: () {},
                                  title: 'Search',
                                  borderColor: SColors.secondaryColor,
                                ),
                              ),
                              SizedBox(width: SSizes.spaceBtwItems / 2),
                              Expanded(
                                child: ButtonWithIconAndText(
                                  icon: CupertinoIcons.xmark,
                                  onPressed: () {},
                                  title: 'Reset',
                                  borderColor: SColors.error,
                                ),
                              ),
                              SizedBox(width: SSizes.spaceBtwItems / 2),
                              Expanded(
                                child: ButtonWithIconAndText(
                                  icon: Iconsax.export,
                                  onPressed: () {},
                                  title: 'Export',
                                  borderColor: Colors.green,
                                ),
                              ),
                              SizedBox(width: SSizes.spaceBtwItems / 2),
                              Expanded(
                                flex: 9,
                                child: Container(),
                              ),
                            ],
                          ),

                          SizedBox(height: SSizes.spaceBtwItems),

                          Divider(thickness: 2),


                          SizedBox(height: SSizes.spaceBtwSections),

                          MyUserDetails()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
  }

}