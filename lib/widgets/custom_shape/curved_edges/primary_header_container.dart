import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../containers/circular_container.dart';
import 'curved_edge_widget.dart';

class SPrimaryHeaderContainer extends StatelessWidget {
  const SPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SCurvedEdgeWidget(
      child: Container(
        color: SColors.primaryColor,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
                top: -80,
                right: -100,
                child: SRoundedContainer(
                  height: 250,
                    width: 250,
                    radius: 250,
                    backgroundColor: SColors.textWhite.withOpacity(0.1))),
            Positioned(
                top: 100,
                right: -180,
                child: SRoundedContainer(
                  height: 250,
                    width: 250,
                    radius: 250,
                    backgroundColor: SColors.textWhite.withOpacity(0.1))),
            child
          ],
        ),
      ),
    );
  }
}
