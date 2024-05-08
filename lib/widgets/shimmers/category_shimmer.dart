import 'package:flutter/cupertino.dart';

import '../../utils/constants/sizes.dart';
import 'shimmer.dart';

class SCategoryShimmer extends StatelessWidget {
  const SCategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_,__) => const SizedBox(width: SSizes.spaceBtwItems),
        itemBuilder: (_,__){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Image
              SShimmerEffect(height: 55, width: 55, radius: 55),
              SizedBox(height: SSizes.spaceBtwItems/2),

              /// Text
              SShimmerEffect(height: 8, width: 8)
            ],
          );
        },
      ),
    );
  }
}
