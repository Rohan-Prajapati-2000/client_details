import 'package:flutter/material.dart';

import '../../utils/constants/sizes.dart';

class SRoundedImage extends StatelessWidget {
  const SRoundedImage({
    super.key,
    this.border,
    this.padding,
    this.onPressed,
    this.width = double.infinity,
    this.height = 250,
    this.applyImageRadius = true,
    required this.imageUrl,
    this.boxFit = BoxFit.cover,
    this.backgroundColor,
    this.isNetworkImage = false,
    this.borderRadius = SSizes.md,
  });

  final double? height, width;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? boxFit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            border: border,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: Image(
              fit: boxFit,
              image: isNetworkImage
                  ? NetworkImage(imageUrl)
                  : AssetImage(imageUrl) as ImageProvider),
        ),
      ),
    );
  }
}