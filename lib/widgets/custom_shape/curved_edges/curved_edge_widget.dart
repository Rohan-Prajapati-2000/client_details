import 'package:flutter/material.dart';

import 'curved_edge.dart';

class SCurvedEdgeWidget extends StatelessWidget {
  const SCurvedEdgeWidget({
    super.key, this.child,
  });

  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SCustomCurevedEdge(),
      child: child,
    );
  }
}