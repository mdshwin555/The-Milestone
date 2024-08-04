import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/common/widgets/text_field.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/personal_info_widgets/action_buttons_widget.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/personal_info_widgets/dropdown_field_widget.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/personal_info_widgets/header_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import '../controller/personal_info_controller.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalInfoController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 10.h,
            left: 6.w,
            right: 6.w,
          ),
          height: 100.h,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                Color(0xFFE7EDF7),
                Color(0xFFFFFFFF),
              ])),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),
                const HeaderWidget(),
                SizedBox(height: 7.h),
                TTextField(
                  hintText: "Full Name",
                  prefixIcon: Icon(Icons.person_3_outlined),
                  controller: controller.fullNameController,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    controller.fullName.value = value;
                    controller.validateForm();
                  },
                ),
                SizedBox(height: 2.h),
                TTextField(
                  hintText: "Phone",
                  prefixIcon: Icon(Iconsax.mobile4),
                  controller: controller.idController,
                  keyboardType: TextInputType.number,
                  isNationalID: true,
                  onChanged: (value) {
                    controller.nationalId.value = value;
                    controller.validateForm();
                  },
                  isPhone: true,
                ),
                SizedBox(height: 2.h),
                TTextField(
                  hintText: "Date of Birth",
                  prefixIcon: Icon(Iconsax.calendar),
                  controller: controller.shopController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    controller.businessName.value = value;
                    controller.validateForm();
                  },
                ),
                SizedBox(height: 2.h),
                TTextField(
                  hintText: "address",
                  prefixIcon: Icon(Icons.home_outlined),
                  controller: controller.addressController,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    controller.fullName.value = value;
                    controller.validateForm();
                  },
                ),
                SizedBox(height: 2.h),
                DropdownFieldWidget(
                  value: controller.gender.value.isEmpty
                      ? null
                      : controller.gender.value,
                  onChanged: (value) {
                    controller.gender.value = value!;
                    controller.validateForm();
                  },
                ),
                SizedBox(height: 5.h),
                const ActionButtonsWidget(),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
