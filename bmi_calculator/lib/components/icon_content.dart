import 'package:flutter/material.dart';
import 'package:bmi_calculator/constants.dart';

class IconContent extends StatelessWidget {
  const IconContent({super.key, this.icon, this.label});

  final IconData? icon;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (icon != null) Icon(icon, size: 80.0),
        SizedBox(height: 15.0),
        if (label != null) Text(label!, style: kLabelTextStyle),
      ],
    );
  }
}
