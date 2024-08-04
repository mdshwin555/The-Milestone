import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/auth/controller/login_controller.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/login_widgets/label_text_field.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/login_widgets/logo_image.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/login_widgets/privacy_policy.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/button.dart';
import '../../../common/widgets/text_field.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    final TextEditingController phoneController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const LogoImage(),
            Positioned(
              top: 32.5.h,
              left: 10.w,
              child: Text(
                'سرعة وثقة في كل شحنة',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: TColors.textPrimary,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
            Positioned(
              top: 31.h,
              right: 10.w,
              child: Image(
                height: 5.h,
                image: AssetImage(
                  TImages.kwickly,
                ),
              ),
            ),
            const LabelTextField(),
            Positioned(
              top: 47.h,
              child: TTextField(
                hintText: '--- ---- 7 962+',
                prefixIcon: Icon(Icons.phone_android_outlined,
                    color: TColors.primary, size: 19.sp),
                controller: phoneController,
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  controller.updatePhoneNumber(value);
                  phoneController.text = controller.phoneNumber.value;
                  phoneController.selection = TextSelection.fromPosition(
                    TextPosition(offset: phoneController.text.length),
                  );
                },
                showPrefix: true,
                isPhone: true,
              ),
            ),
            PrivacyPolicy(),
            Positioned(
              bottom: 10.h,
              left: 2.w,
              child: Obx(
                () => TButton(
                  text: controller.isLoading.value
                      ? 'جاري التحميل...'
                      : 'تسجيل دخول',
                  onPressed: () {
                    if (!controller.isLoading.value &&
                        phoneController.text.isNotEmpty &&
                        controller.errorMessage.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '+9627${controller.phoneNumber.value}',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: TColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'هل هذا هو رقمك الصحيح؟',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: TColors.textPrimary,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'تعديل',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: TColors.primary,
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        controller.login();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: TColors.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        'تأكيد',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: 'Cairo',
                                          color: TColors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            Obx(
              () => controller.errorMessage.isNotEmpty
                  ? Positioned(
                      top: 55.h,
                      left: 2.w,
                      right: 2.w,
                      child: Text(
                        controller.errorMessage.value,
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Cairo',
                          fontSize: 9.sp
                        ),
                        textAlign: TextAlign.right,
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
