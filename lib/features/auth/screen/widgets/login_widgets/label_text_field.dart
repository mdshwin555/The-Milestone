import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/constants/colors.dart';

class LabelTextField extends StatelessWidget {
  final String label;

  const LabelTextField({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 12.sp,
        color: TColors.primary,
        fontWeight: FontWeight.bold,
        fontFamily: "Cairo",
      ),
    );
  }
}
