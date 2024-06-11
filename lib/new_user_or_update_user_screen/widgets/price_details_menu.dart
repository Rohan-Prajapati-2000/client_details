import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice/utils/constants/sizes.dart';
import '../controller/save_form_data_controller.dart';
import 'main_heading.dart';
import 'validity_dropdown.dart';

class PriceDetailsMenu extends StatelessWidget {
  PriceDetailsMenu({super.key});

  final SaveFromDataController controller = SaveFromDataController.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultSpace * 5),
      child: Column(
        children: [
          MainHeading(),
          const SizedBox(height: SSizes.spaceBtwSections / 2),
          buildSubscriptionRow(
            context,
            controller.isCheckedSEO,
            'Local Keyword SEO',
            controller.totalAmountSEO,
            controller.receivedAmountSEO,
            controller.validitySEO,
          ),
          buildSubscriptionRow(
            context,
            controller.isCheckedVirtualTour,
            'Virtual Tour',
            controller.totalAmountVirtualTour,
            controller.receivedAmountVirtualTour,
            controller.validityVirtualTour,
          ),
          buildSubscriptionRow(
            context,
            controller.isCheckedGBPM,
            'Google Business Profile Management',
            controller.totalAmountGBPM,
            controller.receivedAmountGBPM,
            controller.validityGBPM,
          ),
          buildSubscriptionRow(
            context,
            controller.isCheckedZKSEO,
            'Zonal Keyword SEO',
            controller.totalAmountZKSEO,
            controller.receivedAmountZKSEO,
            controller.validityZKSEO,
          ),


        ],
      ),
    );
  }

  Widget buildSubscriptionRow(
    BuildContext context,
    RxBool isChecked,
    String title,
    TextEditingController totalAmountController,
    TextEditingController receivedAmountController,
    RxString validity,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(
          () => Checkbox(
            value: isChecked.value,
            onChanged: (value) {
              isChecked.value = value!;
            },
          ),
        ),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.visible,
          ),
        ),
        Obx(
          () => isChecked.value
              ? Expanded(
                  child: ValidityDropDown(
                    selectedValue: validity.value,
                    onSelected: (val) {
                      validity.value = val;
                    },
                  ),
                )
              : SizedBox(),
        ),
        Obx(
          () => isChecked.value
              ? Expanded(
                  child: TextFormField(
                    controller: totalAmountController,
                    decoration: InputDecoration(hintText: 'Total Amount'),
                  ),
                )
              : SizedBox(),
        ),
        Obx(
          () => isChecked.value
              ? Expanded(
                  child: TextFormField(
                    controller: receivedAmountController,
                    decoration: InputDecoration(hintText: 'Balance Amount'),
                  ),
                )
              : SizedBox(),
        ),
      ],
    );
  }
}
