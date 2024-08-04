import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/features/auth/screen/reset_password_screen.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/login_widgets/label_text_field.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/verification_widgets/header_widget_two.dart';
import 'package:shipment_merchent_app/utils/constants/image_strings.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/text_field.dart';
import '../../../utils/constants/colors.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/verification_widgets/submit_button_widget.dart';


class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);
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
                          image: AssetImage(TImages.forget_password),
                          height: 38.h,
                        ),
                      ),
                      Positioned(
                        top: 52.h,
                        child: const HeaderWidgetTwo(titleText: 'Forget password', bodyText: 'Don’t worry sometimes people can forget too, enter your email and we will send you a password reset link',),
                      ),
                      Positioned(
                        top: 70.h,
                        child: TTextField(
                          hintText: 'example@gmail.com',
                          prefixIcon: Icon(Icons.email_outlined,
                              color: TColors.primary, size: 19.sp),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          showPrefix: true,
                          isPhone: false,
                        ),
                      ),
                      Positioned(
                        bottom: 10.h,
                        left: 2.w,
                        child:  SubmitButtonWidget(destination: ResetPasswordScreen(),),
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
