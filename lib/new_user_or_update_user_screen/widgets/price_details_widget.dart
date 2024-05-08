import 'package:flutter/material.dart';
import 'package:practice/new_user_or_update_user_screen/widgets/validity_dropdown.dart';
import 'package:practice/utils/constants/sizes.dart';

class PriceDetailsWidget extends StatelessWidget {
  final String productTitle;

  const PriceDetailsWidget({
    required this.productTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SSizes.spaceBtwItems / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                Expanded(
                  child: Text(
                    productTitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ValidityDropDown(),
              ],
            ),
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(

              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                
              ),
            ),
          ),
        ],
      ),
    );
  }
}