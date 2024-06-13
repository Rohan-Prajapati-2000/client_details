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
          const MainHeading(),
          const SizedBox(height: SSizes.spaceBtwSections / 2),
          buildSubscriptionRow(
            context,
            controller.isCheckedSEO,
            'Local Keyword SEO',
            controller.totalAmountSEO,
            controller.receivedAmountSEO,
            controller.validitySEO,
          ),
          SizedBox(height: SSizes.spaceBtwItems),
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

          buildSubscriptionRow(
            context,
            controller.isCheckedGoogleAds,
            'Google Ads',
            controller.totalAmountGoogleAds,
            controller.receivedAmountGoogleAds,
            controller.validityGoogleAds,
          ),

          buildSubscriptionRow(
            context,
            controller.isCheckedGoogleAdsRecharge,
            'Google Ads Recharge',
            controller.totalAmountGoogleAdsRecharge,
            controller.receivedAmountGoogleAdsRecharge,
            controller.validityGoogleAdsRecharge,
          ),

          buildSubscriptionRow(
            context,
            controller.isCheckedFacebook,
            'Facebook',
            controller.totalAmountFacebook,
            controller.receivedAmountFacebook,
            controller.validityFacebook,
          ),

          buildSubscriptionRow(
            context,
            controller.isCheckedFacebookRecharge,
            'Facebook ads Recharge',
            controller.totalAmountFacebookRecharge,
            controller.receivedAmountFacebookRecharge,
            controller.validityFacebookRecharge,
          ),

          buildSubscriptionRow(
            context,
            controller.isCheckedWebsite,
            'Website',
            controller.totalAmountWebsite,
            controller.receivedAmountWebsite,
            controller.validityWebsite,
          ),

          buildSubscriptionRow(
            context,
            controller.isCheckedCustomDevelopment,
            'Custom Development',
            controller.totalAmountCustomDevelopment,
            controller.receivedAmountCustomDevelopment,
            controller.validityCustomDevelopment,
          ),

          buildSubscriptionRow(
            context,
            controller.isCheckedWebsiteAmc,
            'Website Amc',
            controller.totalAmountWebsiteAmc,
            controller.receivedAmountWebsiteAmc,
            controller.validityWebsiteAmc,
          ),

          buildSubscriptionRow(
            context,
            controller.isCheckedProductPhotography,
            'Product Photography',
            controller.totalAmountProductPhotography,
            controller.receivedAmountProductPhotography,
            controller.validityProductPhotography,
          ),

          buildSubscriptionRow(
            context,
            controller.isCheckedDomain,
            'Domain',
            controller.totalAmountDomain,
            controller.receivedAmountDomain,
            controller.validityDomain,
          ),

          buildSubscriptionRow(
            context,
            controller.isCheckedHosting,
            'Hosting',
            controller.totalAmountHosting,
            controller.receivedAmountHosting,
            controller.validityHosting,
          ),

          buildSubscriptionRow(
            context,
            controller.isCheckedQrCode,
            'QR Code',
            controller.totalAmountQrCode,
            controller.receivedAmountQrCode,
            controller.validityQrCode,
          ),

          buildSubscriptionRow(
            context,
            controller.isCheckedWebSEO,
            'Web SEO',
            controller.totalAmountWebSEO,
            controller.receivedAmountWebSEO,
            controller.validityWebSEO,
          ),

          buildSubscriptionRow(
            context,
            controller.isCheckedOthers,
            'Others',
            controller.totalAmountOthers,
            controller.receivedAmountOthers,
            controller.validityOthers,
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

        const SizedBox(width: SSizes.spaceBtwItems),

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

        const SizedBox(width: SSizes.spaceBtwItems),

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
