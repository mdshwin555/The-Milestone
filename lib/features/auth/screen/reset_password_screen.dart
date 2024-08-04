import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/login_widgets/label_text_field.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/verification_widgets/header_widget_two.dart';
import 'package:shipment_merchent_app/utils/constants/image_strings.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/text_button.dart';
import '../../../common/widgets/text_field.dart';import '../../../navigation_menu.dart';
import '../../../utils/constants/colors.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/verification_widgets/submit_button_widget.dart';

import '../../home/screen/home_screen.dart';


class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            right: 6.w,
            left: 6.w,
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
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 10.h,
                        child: Image(
                          image: AssetImage(TImages.receives_mail),
                          height: 38.h,
                        ),
                      ),
                      Positioned(
                        top: 54.h,
                        child: const HeaderWidgetTwo(titleText: 'Password Reset Email Sent', bodyText: 'A password reset link has been sent to your email. Please check your inbox to reset your password.',),
                      ),

                      Positioned(
                        bottom: 15.h,
                        left: 2.w,
                        child: const SubmitButtonWidget(destination: NavigationMenu(),),
                      ),
                      Positioned(
                        bottom: 5.h,
                        child: TTextButton(
                          text: 'Resend Email',
                          onPressed: () {
                            //Get.back();
                          },
                        ),
                      ),
                    ],
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
