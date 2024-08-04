import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/personalization/screens/privacy_policy_screen.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import '../../../../personalization/screens/terms_and_conditions_screen.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Positioned(
        bottom: 20.h,
        left: 2.w,
        child: Container(
          width: 90.w,
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'By tapping Submit or Continue as Guest \n You are agreeing to  ',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.black,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: ' Terms & conditions ',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: TColors.primary,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.to(TermsAndConditionsScreen());
                    },
                ),
                TextSpan(
                  text: ' and',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.black,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: ' Privacy Policy ',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: TColors.primary,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.to(PrivacyPolicyScreen());
                    },
                ),
              ],
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ),
    );
  }
}
