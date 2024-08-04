import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/constants/colors.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'personal information',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: TColors.primary,
            fontFamily: 'Cairo',
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          'Enter your information and stay informed about every thing related to the institute .',
          style: TextStyle(
            fontSize: 11.sp,
            color: TColors.darkGrey,
            fontFamily: 'Cairo',
          ),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
