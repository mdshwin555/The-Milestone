import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/profile_widgets/profile_buttons.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/colored_app_bar.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../controller/profile_controller.dart';
import '../../../common/widgets/text_field.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const TCAppBar(
        title: 'My Profile',
        showBackArrow: true,
        isProfile: true,
      ),
      backgroundColor: Color(0xFFFFFFFF),
      body: Container(
        height: 100.h,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xFFE7EDF7),
                  Color(0xFFFFFFFF),
                ])),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomSizedBox.itemSpacingVertical(),
                CustomSizedBox.itemSpacingVertical(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TTextField(
                          hintText: 'Name',
                          suffixIcon:
                          Icon(Iconsax.user, color: TColors.primary, size: 19.sp),
                          controller: controller.nameController,
                          keyboardType: TextInputType.visiblePassword,
                          showPrefix: true,
                        ),
                        CustomSizedBox.itemSpacingVertical(height: 0.2.h),
                        TTextField(
                          hintText: 'Email',
                          suffixIcon:
                          Icon(Icons.email_outlined, color: TColors.primary, size: 19.sp),
                          controller: controller.emailController,
                          keyboardType: TextInputType.visiblePassword,
                          showPrefix: true,
                        ),
                        CustomSizedBox.itemSpacingVertical(height: 0.2.h),
                        TTextField(
                          hintText: 'Birth Of Date',
                          suffixIcon:
                          Icon(Icons.date_range, color: TColors.primary, size: 19.sp),
                          controller: controller.birthdateController,
                          keyboardType: TextInputType.visiblePassword,
                          showPrefix: true,
                        ),
                        CustomSizedBox.itemSpacingVertical(height: 0.2.h),
                        TTextField(
                          hintText: 'Address',
                          suffixIcon:
                          Icon(Icons.home_outlined, color: TColors.primary, size: 19.sp),
                          controller: controller.birthdateController,
                          keyboardType: TextInputType.visiblePassword,
                          showPrefix: true,
                        ),
                        CustomSizedBox.itemSpacingVertical(height: 0.2.h),
                        TTextField(
                          hintText: 'Study',
                          suffixIcon:
                          Icon(Icons.work_outline, color: TColors.primary, size: 19.sp),
                          controller: controller.birthdateController,
                          keyboardType: TextInputType.visiblePassword,
                          showPrefix: true,
                        ),
                        CustomSizedBox.itemSpacingVertical(height: 1.h),
                        ProfileButtons(controller: controller),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
