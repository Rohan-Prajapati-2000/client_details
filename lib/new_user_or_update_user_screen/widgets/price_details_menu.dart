import 'package:flutter/material.dart';
import 'package:practice/utils/constants/sizes.dart';

import 'price_details_widget.dart';

class PriceDetailsMenu extends StatelessWidget {
  const PriceDetailsMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultSpace * 5),
      child: Column(
        children: [

          /// Menu Headings
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text('Product',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              Expanded(
                child: Text('Validity',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              Expanded(
                child: Text('Total Amount',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              Expanded(
                child: Text('Balance Amount',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
            ],
          ),

          SizedBox(height: SSizes.spaceBtwSections/2),

          PriceDetailsWidget(productTitle: 'Local Keyword SEO' ),
          SizedBox(height: SSizes.spaceBtwItems/2),
          PriceDetailsWidget(productTitle: 'Virtual Tour' ),
          SizedBox(height: SSizes.spaceBtwItems/2),
          PriceDetailsWidget(productTitle: 'Google Business Profile Management' ),
          SizedBox(height: SSizes.spaceBtwItems/2),
          PriceDetailsWidget(productTitle: 'Zonal Ads Recharge' ),
          SizedBox(height: SSizes.spaceBtwItems/2),
          PriceDetailsWidget(productTitle: 'Google Ads' ),
          SizedBox(height: SSizes.spaceBtwItems/2),
          PriceDetailsWidget(productTitle: 'Google Ads Recharge' ),
          SizedBox(height: SSizes.spaceBtwItems/2),
          PriceDetailsWidget(productTitle: 'Facebook' ),
          SizedBox(height: SSizes.spaceBtwItems/2),
          PriceDetailsWidget(productTitle: 'Facebook Ads Recharge' ),
          SizedBox(height: SSizes.spaceBtwItems/2),
          PriceDetailsWidget(productTitle: 'Website' ),
          SizedBox(height: SSizes.spaceBtwItems/2),
          PriceDetailsWidget(productTitle: 'Custom Devlopment' ),
          SizedBox(height: SSizes.spaceBtwItems/2),
          PriceDetailsWidget(productTitle: 'Website AMC' ),
          SizedBox(height: SSizes.spaceBtwItems/2),
          PriceDetailsWidget(productTitle: 'Product Photography' ),
          SizedBox(height: SSizes.spaceBtwItems/2),
          PriceDetailsWidget(productTitle: 'Domain' ),
          SizedBox(height: SSizes.spaceBtwItems/2),
          PriceDetailsWidget(productTitle: 'Hosting' ),
          SizedBox(height: SSizes.spaceBtwItems/2),
          PriceDetailsWidget(productTitle: 'QR Code' ),
          SizedBox(height: SSizes.spaceBtwItems/2),
          PriceDetailsWidget(productTitle: 'Web SEO' ),
          SizedBox(height: SSizes.spaceBtwItems/2),
          PriceDetailsWidget(productTitle: 'Others' ),
        ],
      ),
    );
  }
}

