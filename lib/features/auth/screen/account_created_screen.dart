import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/auth/screen/forget_password_screen.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/verification_widgets/header_widget_two.dart';
import 'package:shipment_merchent_app/utils/constants/image_strings.dart';
import 'package:sizer/sizer.dart';
import '../controller/animation_controller.dart';
import '../controller/verify_controller.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/verification_widgets/header_widget.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/verification_widgets/pinput_widget.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/verification_widgets/resend_code_widget.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/verification_widgets/submit_button_widget.dart';


class AccountCreatedScreen extends StatelessWidget {
  AccountCreatedScreen({Key? key}) : super(key: key);


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
                    children: [
                      Positioned(
                        top: 10.h,
                        child: Image(
                          image: AssetImage(TImages.celebrate),
                          height: 38.h,
                        ),
                      ),
                      Positioned(
                        top: 55.h,
                        child: const HeaderWidgetTwo(titleText: 'Your account \n successfully created!', bodyText:'Welcome to our premier language institute! Your account has been successfully created, allowing you to embark on a journey of seamless language learning and exploration!' ,),
                      ),
                      Positioned(
                        bottom: 10.h,
                        left: 2.w,
                        child:  SubmitButtonWidget(destination: ForgetPasswordScreen(),),
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
