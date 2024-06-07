import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:practice/new_user_or_update_user_screen/new.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../home_screen/my_user_details.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';
import 'button_icon_with_text.dart';
import 'expired_pending_dropdown_button.dart';
import 'month_dropdown_button.dart';
import 'year_dropdown_button.dart';

class MyHomeHeader extends StatefulWidget {
  const MyHomeHeader({super.key});

  @override
  State<MyHomeHeader> createState() => _MyHomeHeaderState();
}

class _MyHomeHeaderState extends State<MyHomeHeader> {
  final TextEditingController _companyNameController = TextEditingController();
  final ValueNotifier<String> _selectedCompanyNameNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> _selectedYearNotifier = ValueNotifier<String>('');
  @override
  void dispose() {
    _companyNameController.dispose();
    _selectedCompanyNameNotifier.dispose();
    _selectedYearNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(SSizes.defaultSpace / 2),
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
              const SizedBox(width: SSizes.spaceBtwItems),
              SizedBox(
                height: 35,
                width: 140,
                child: TextButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: SColors.secondaryColor),
                    ),
                  ),
                  onPressed: () => Get.to(() => NewUser()),
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
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: SSizes.spaceBtwItems * 2, vertical: SSizes.spaceBtwItems / 1.8),
                  child: Text(
                    'Details',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                const Divider(),
                const SizedBox(height: SSizes.spaceBtwItems),
                Padding(
                  padding: const EdgeInsets.all(SSizes.defaultSpace),
                  child: Column(
                    children: [
                      // FILTER
                      Row(
                        children: [
                          Expanded(
                            child: Autocomplete<String>(
                              optionsBuilder: (TextEditingValue textEditingValue) async {
                                if (textEditingValue.text.isEmpty) {
                                  return const Iterable<String>.empty();
                                }
                                // Fetch matching company names from Firestore
                                QuerySnapshot snapshot = await FirebaseFirestore.instance
                                    .collection('client_details')
                                    .where('Company Name', isGreaterThanOrEqualTo: textEditingValue.text)
                                    .where('Company Name', isLessThanOrEqualTo: '${textEditingValue.text}\uf8ff')
                                    .get();
                                List<String> companyNames = snapshot.docs.map((doc) => doc['Company Name'] as String).toList();
                                return companyNames;
                              },
                              fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                                _companyNameController.text = textEditingController.text;
                                return TextField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  decoration: const InputDecoration(labelText: 'Company Name'),
                                );
                              },
                              onSelected: (String selection) {
                                _companyNameController.text = selection;
                                _selectedYearNotifier.value = selection;
                              },
                            ),
                          ),
                          const SizedBox(width: SSizes.spaceBtwItems / 2),
                          Expanded(child: YearDropdownButton(
                            onYearChange: (years) {
                              _selectedYearNotifier.value = years;
                            },
                          )),
                          const SizedBox(width: SSizes.spaceBtwItems / 2),
                          Expanded(child: MonthDropdownButton()),
                          const SizedBox(width: SSizes.spaceBtwItems / 2),
                          Expanded(child: ExpiredAndPendingDropdownButton()),
                          const SizedBox(width: SSizes.spaceBtwItems / 2),
                        ],
                      ),

                      const SizedBox(height: SSizes.spaceBtwItems),

                      Row(
                        children: [
                          Expanded(
                            child: ButtonWithIconAndText(
                              icon: CupertinoIcons.search,
                              onPressed: () {
                                _selectedCompanyNameNotifier.value = _companyNameController.text;
                              },
                              title: 'Search',
                              borderColor: SColors.secondaryColor,
                            ),
                          ),
                          const SizedBox(width: SSizes.spaceBtwItems / 2),
                          Expanded(
                            child: ButtonWithIconAndText(
                              icon: CupertinoIcons.xmark,
                              onPressed: () {
                                _selectedCompanyNameNotifier.value = '';
                                _companyNameController.clear();
                                _selectedYearNotifier.value = 'Select Year';
                              },
                              title: 'Reset',
                              borderColor: SColors.error,
                            ),
                          ),
                          const SizedBox(width: SSizes.spaceBtwItems / 2),
                          Expanded(
                            child: ButtonWithIconAndText(
                              icon: Iconsax.export,
                              onPressed: () {},
                              title: 'Export',
                              borderColor: Colors.green,
                            ),
                          ),
                          const SizedBox(width: SSizes.spaceBtwItems / 2),
                          const Expanded(
                            flex: 9,
                            child: SizedBox(),
                          ),
                        ],
                      ),

                      const SizedBox(height: SSizes.spaceBtwItems),

                      const Divider(thickness: 2),

                      const SizedBox(height: SSizes.spaceBtwSections),

                      // Use ValueListenableBuilder to update MyUserDetails
                      ValueListenableBuilder<String>(
                        valueListenable: _selectedCompanyNameNotifier,
                        builder: (context, selectedCompanyName, child) {
                          return ValueListenableBuilder<String>(
                              valueListenable : _selectedYearNotifier,
                              builder: (context, year, child) {
                                return MyUserDetails(companyName: selectedCompanyName, year: year);
                              },
                          );
                        },
                      ),
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
