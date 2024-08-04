import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../controller/verify_controller.dart';

class HeaderWidgetTwo extends StatelessWidget {
  final String titleText;
  final String bodyText;

  const HeaderWidgetTwo({
    Key? key,
    required this.titleText,
    required this.bodyText,
  }) : super(key: key);

  String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith('+962') && phoneNumber.length == 13) {
      return '+962 7 ${phoneNumber.substring(5, 9)} ${phoneNumber.substring(9)}';
    }
    return phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    final VerifyController controller = Get.find();

    return Container(
      width: 88.w,
      child: Column(
        children: [
          Text(
            titleText,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: TColors.primary,
              fontFamily: 'Cairo',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.h),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: bodyText,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: TColors.darkGrey,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          Obx(
                () => controller.errorMessage.value.isNotEmpty
                ? Text(
              controller.errorMessage.value,
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.left,
            )
                : Container(),
          ),
        ],
      ),
    );
  }
}
