import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';

class SCircularIcon extends StatelessWidget {
  /// A custom circular icon widget with a background color
  ///
  /// Properties are-
  /// containers [height], [width], [backgroundColor]
  ///
  /// icon's [size], [color], [onPressed]

  const SCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = SSizes.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });

   final double? width, height, size;
   final IconData icon;
   final Color? color;
   final Color? backgroundColor;
   final VoidCallback? onPressed;


  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Container(
      width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: backgroundColor != null ? backgroundColor! : dark ? SColors.black.withOpacity(0.9) : SColors.white.withOpacity(0.9),
        ),
        child: IconButton(onPressed: onPressed, icon: Icon(icon, color: color, size: size))
    );
  }
}