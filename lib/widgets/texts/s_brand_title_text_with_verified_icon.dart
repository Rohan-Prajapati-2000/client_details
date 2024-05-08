import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/enums.dart';
import '../../utils/constants/sizes.dart';
import 's_brand_text_title.dart';

class SBrandTitleWithVerifiedIcon extends StatelessWidget {
  const SBrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLine = 1,
    this.textColor,
    this.iconColor = SColors.primaryColor,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLine;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SBrandTextTitle(
          title: title,
          color: textColor,
          maxLine: maxLine,
          textAlign: textAlign,
          brandTextSize: brandTextSize,
        ),
        const SizedBox(width: SSizes.sm),
        const Icon(Iconsax.verify5, color: SColors.primaryColor, size: SSizes.iconXs)
      ],
    );
  }
}
