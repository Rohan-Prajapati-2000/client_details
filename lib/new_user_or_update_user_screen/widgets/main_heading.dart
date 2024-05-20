import 'package:flutter/material.dart';

class MainHeading extends StatelessWidget {
  const MainHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text('Product',
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        Expanded(
          child: Text('Validity',
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        Expanded(
          child: Text('Total Amount',
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        Expanded(
          child: Text('Balance Amount',
              style: Theme.of(context).textTheme.headlineSmall),
        ),
      ],
    );
  }
}
