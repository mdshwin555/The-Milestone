import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/widgets/button.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/common/widgets/text_button.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/personal_info_controller.dart';
import '../../account_created_screen.dart';

class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PersonalInfoController>();

    return Column(
      children: [
        Obx(
              () => TButton(
            text: controller.isLoading.value ? 'LOADING...' : 'continue',
            onPressed:(){
              Get.to(AccountCreatedScreen());
            }
          ),
        ),
        CustomSizedBox.itemSpacingVertical(),
        Align(
          alignment: Alignment.center,
          child: TTextButton(
            text: 'Back',
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ],
    );
  }
}
