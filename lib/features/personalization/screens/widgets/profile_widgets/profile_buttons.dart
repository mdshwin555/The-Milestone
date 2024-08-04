import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/widgets/button.dart';
import '../../../../../common/widgets/text_button.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../auth/screen/login_screen.dart';
import '../../../controller/profile_controller.dart';

class ProfileButtons extends StatelessWidget {
  final ProfileController controller;

  const ProfileButtons({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TButton(
          text: 'تسجيل خروج',
          onPressed: () {
            // controller.editProfile(
            //   controller.nameController.text,
            //   controller.phoneController.text,
            //   controller.businessNameController.text,
            // );
          },
        ),

      ],
    );
  }
}
