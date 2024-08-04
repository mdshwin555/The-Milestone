import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/features/auth/controller/login_controller.dart';
import 'package:shipment_merchent_app/features/auth/screen/verification_screen.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/login_widgets/label_text_field.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/login_widgets/logo_image.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/login_widgets/privacy_policy.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/button.dart';
import '../../../common/widgets/text_button.dart';
import '../../../common/widgets/text_field.dart';
import '../../../utils/constants/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        height: 100.h,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
              Color(0xFFE7EDF7),
              Color(0xFFFFFFFF),
            ])),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const LogoImage(),
            Positioned(
                top: 37.h,
                left: 2.w,
                child: const LabelTextField(
                  label: 'Email',
                )),
            Positioned(
              top: 41.h,
              child: TTextField(
                hintText: 'example@gmail.com',
                prefixIcon: Icon(Icons.email_outlined,
                    color: TColors.primary, size: 19.sp),
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                showPrefix: true,
                isPhone: false,
              ),
            ),
            Positioned(
                top: 51.h,
                left: 2.w,
                child: const LabelTextField(
                  label: 'Password',
                )),
            Positioned(
              top: 55.h,
              child: TTextField(
                hintText: '*************',
                prefixIcon:
                    Icon(Iconsax.lock_1, color: TColors.primary, size: 19.sp),
                controller: controller.passwordController,
                keyboardType: TextInputType.visiblePassword,
                showPrefix: true,
                isPassword: true,
              ),
            ),
            PrivacyPolicy(),
            Positioned(
              bottom: 10.h,
              left: 2.w,
              child: Obx(
                () => TButton(
                  text: controller.isLoading.value ? ' LOADING...' : 'SUBMIT',
                  // onPressed: controller.login,
                  onPressed: () {
                    Get.to(VerifyScreen());
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 3.h,
              child: TTextButton(
                text: 'Continue as guest',
                onPressed: () {
                  Get.back();
                },
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
                        style: TextStyle(color: Colors.red),
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
