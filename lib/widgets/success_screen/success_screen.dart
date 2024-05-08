import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';

class SuccessScreen extends StatelessWidget {
  final String? image, animationLottie;
  final String title, subtitle;
  final VoidCallback onPressed;

  const SuccessScreen({
    Key? key,
    this.image,
    this.animationLottie,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              /// Image
              if (image != null)
                Image(
                  image: AssetImage(image!),
                  width: SHelperFunctions.screenWidth() * 0.6,
                ),
              if (image != null) const SizedBox(height: SSizes.spaceBtwSections),

              /// Lottie animation
              if (animationLottie != null)
                Lottie.asset(
                  animationLottie!,
                  width: SHelperFunctions.screenWidth() * 0.6,
                ),
              if (animationLottie != null) const SizedBox(height: SSizes.spaceBtwSections),

              /// Title and Subtitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SSizes.spaceBtwSections),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SSizes.spaceBtwSections),

              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(SText.scontinue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
