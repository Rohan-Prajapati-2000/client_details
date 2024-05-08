import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/constants/sizes.dart';
import '../utils/helpers/helper_functions.dart';

class ButtonWithIconAndText extends StatelessWidget {
  const ButtonWithIconAndText(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.title,
      required this.borderColor});

  final IconData icon;
  final VoidCallback onPressed;
  final String title;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return TextButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: borderColor,
              )
          )
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: dark ? Colors.white : Colors.black),
          SizedBox(width: SSizes.spaceBtwItems / 2),
          Text(title, style: Theme.of(context).textTheme.titleMedium)
        ],
      ),
    );
  }
}
