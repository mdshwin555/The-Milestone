import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/personalization/screens/teacher_details_screen.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/utils/constants/image_strings.dart';
import 'package:sizer/sizer.dart';

import '../../../common/widgets/colored_app_bar.dart';

class OurTeachersScreen extends StatelessWidget {
  const OurTeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TCAppBar(
        title: 'Our Teachers',
        showBackArrow: true,
      ),
      body: Container(
        height: 100.h,
        //padding: EdgeInsets.symmetric(horizontal: ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFFE7EDF7),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4.h,
            crossAxisSpacing: 2.w,
            childAspectRatio: 3 / 4,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Get.to(TeacherDetailsScreen());
              },
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.sp),
                    child: Image.asset(
                      TImages.teacher,
                      width: 30.w,
                      height: 21.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 6.h,
                    left: 0,
                    right: 0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.scale(
                          scaleX: 1.1,
                          child: Image.asset(
                            TImages.ribbon,
                            width: 46.w,
                            height: 5.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 2.3.h,
                          child: Text(
                            'Mr. AlMouayad Shwin',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 8.sp,
                              fontFamily: 'Cairo'
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
