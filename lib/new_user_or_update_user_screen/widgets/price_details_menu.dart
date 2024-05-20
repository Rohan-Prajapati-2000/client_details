import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice/utils/constants/sizes.dart';
import '../../controller/save_form_data_controller.dart';
import '../../model/subscription_model.dart';
import 'main_heading.dart';
import 'validity_dropdown.dart';  // Import your controller

class PriceDetailsMenu extends StatelessWidget {
  PriceDetailsMenu({super.key});

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
            isCheckedSEO,
            'Local Keyword SEO',
            totalAmountSEO,
            receivedAmountSEO,
            validitySEO,
          ),

          buildSubscriptionRow(
            context,
            isCheckedVirtualTour,
            'Virtual Tour',
            totalAmountVirtualTour,
            receivedAmountVirtualTour,
            validityVirtualTour,
          ),

          buildSubscriptionRow(
            context,
            isCheckedGBPM,
            'Google Business Profile Management',
            totalAmountGBPM,
            receivedAmountGBPM,
            validityGBPM,
          ),

          buildSubscriptionRow(
            context,
            isCheckedZKSEO,
            'Zonal Keyword SEO',
            totalAmountZKSEO,
            receivedAmountZKSEO,
            validityZKSEO,
          ),

          ElevatedButton(
            onPressed: () {
              saveSubscriptions();
            },
            child: Text('Save Subscriptions'),
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
              decoration: InputDecoration(hintText: 'Received Amount'),
            ),
          )
              : SizedBox(),
        ),
      ],
    );
  }

  void saveSubscriptions() {
    final controller = SaveFromDataController.instance;

    if (isCheckedSEO.value) {
      controller.addSubscription(
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
      controller.addSubscription(
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
      controller.addSubscription(
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
      controller.addSubscription(
        SubscriptionModel(
          isSelected: true,
          productTitle: 'Zonal Keyword SEO',
          validity: validityZKSEO.value,
          productTotalAmount: totalAmountZKSEO.text,
          productBalanceAmount: receivedAmountZKSEO.text,
        ),
      );
    }

    controller.saveFormDataToFirestore();
  }
}