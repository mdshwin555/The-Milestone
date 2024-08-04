import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../common/widgets/button.dart';
import '../../../controller/verify_controller.dart';

class SubmitButtonWidget extends StatelessWidget {
  final Widget destination;
  final String? buttonText;

  const SubmitButtonWidget({
    Key? key,
    required this.destination,
    this.buttonText = 'CONTINUE',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VerifyController controller = Get.find();

    return Obx(
          () => TButton(
        text: controller.isLoading.value ? 'LOADING...' : buttonText!,
        onPressed: () {
          Get.to(destination);
        },
      ),
    );
  }
}
