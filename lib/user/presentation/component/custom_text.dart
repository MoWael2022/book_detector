import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../core/global_resources/color_manager.dart';

class CustomText extends StatelessWidget {
  CustomText(
      {super.key,
      required this.textName,
      required this.fontSize,
      required this.textColor});

  String textName;
  double fontSize;
  Color textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      textName,
      style: TextStyle(
          fontSize: fontSize, color: textColor),
    );
  }
}
