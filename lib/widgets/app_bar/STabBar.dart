import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/device/device_utility.dart';
import '../../utils/helpers/helper_functions.dart';

class STabBar extends StatelessWidget implements PreferredSizeWidget{
  /// if you want to add background color to tab you have to wrap them in material widget
  /// to do that we need [PreferredSizeWidget] and that's why create custom class.

  const STabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? SColors.black : SColors.white,
      child : TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: SColors.primaryColor,
        labelColor: dark ? SColors.white : SColors.primaryColor,
        unselectedLabelColor: SColors.darkGrey,
      )
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(SDeviceUtility.getAppBarHeight());

}