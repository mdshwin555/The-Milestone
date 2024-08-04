import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/utils/constants/image_strings.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/colored_app_bar.dart';
import '../../auth/screen/reset_password_screen.dart';
import '../../auth/screen/widgets/verification_widgets/header_widget_two.dart';
import '../../auth/screen/widgets/verification_widgets/submit_button_widget.dart';
import '../../home/controller/home_controller.dart';
import '../controller/notification_controller.dart';
import 'package:shipment_merchent_app/common/widgets/text_field.dart';

class BookPlacementTestScreen extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());
  final HomeController controller1 = Get.put(HomeController());

  BookPlacementTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const TCAppBar(
        title: 'Placement Test',
        showBackArrow: true,
      ),
      backgroundColor: TColors.bg,
      body: WillPopScope(
        onWillPop: () => controller1.onWillPop(context),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                Image(
                  image: AssetImage(TImages.Placement_Test),
                  height: 22.h,
                ),
                const HeaderWidgetTwo(
                  titleText: 'Find Your Starting Point',
                  bodyText:
                  ' Our placement process ensures that you begin your language learning journey at the perfect level for your skills.',
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      TTextField(
                        hintText: "Full Name",
                        prefixIcon: Icon(Icons.person_3_outlined),
                        controller: controller.nameController,
                        keyboardType: TextInputType.name,
                        isNationalID: true,
                        onChanged: (value) {
                          // controller.nationalId.value = value;
                          // controller.validateForm();
                        },
                        isPhone: true,
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      TTextField(
                        hintText: "Phone",
                        prefixIcon: Icon(Iconsax.mobile4),
                        controller: controller.phoneController,
                        keyboardType: TextInputType.number,
                        isNationalID: true,
                        onChanged: (value) {
                          // controller.nationalId.value = value;
                          // controller.validateForm();
                        },
                        isPhone: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                SubmitButtonWidget(
                  buttonText: 'BOOK',
                  destination: SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
