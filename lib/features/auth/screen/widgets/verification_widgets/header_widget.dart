import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../controller/verify_controller.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

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
            'Verify your email address!',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: TColors.primary,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 1.h),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Congratulation!Your Account Awaits:Verify \n Your Email by Entering  the verification code which is sent to ',
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
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'ghinwa@gmail.com',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: TColors.darkGrey,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.bold,
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
