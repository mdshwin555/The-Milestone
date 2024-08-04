import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/home/controller/home_controller.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import '../../../common/styles/custom_textstyle.dart';
import '../../../common/widgets/colored_app_bar.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../../utils/constants/image_strings.dart';
import '../../shipment/screen/tracking_screen.dart';
import 'course_info_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());


    return WillPopScope(
      onWillPop: () => controller.onWillPop(context),
      child: Scaffold(
        appBar: const TCAppBar(
          title: 'LEVELS',
          showBackArrow: false,
        ),
        backgroundColor: TColors.bg,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
            padding: EdgeInsets.all(5.w),
            itemCount: 2,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              List<dynamic> shipment = [];
              return Container(
                height: 28.h,
                padding: EdgeInsets.only(top: 2.w),
                child: GestureDetector(
                  onTap: () {
                    Get.to(CourseInfoScreen());
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        left: 2.w,
                        child: Container(
                          height: 27.h,
                          width: 20.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: TColors.grey,
                                  offset: Offset(2, 2),
                                  blurRadius: 5)
                            ],
                            borderRadius: BorderRadius.circular(11.sp),
                            image: DecorationImage(
                                image: AssetImage(TImages.level1),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 8.w,
                        top: 3.h,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Container(
                            padding: EdgeInsets.only(left: 5.w),
                            height: 20.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                              color: TColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: TColors.darkerGrey.withOpacity(0.20),
                                  blurRadius: 8,
                                  spreadRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 2.h, right: 1.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          '2B Course',
                                          style: CustomTextStyle
                                              .headlineTextStyle
                                              .apply(
                                                  fontSizeFactor: 0.9,
                                                  color: TColors.primary,
                                                  fontWeightDelta: 2),
                                        ),
                                      ),
                                      CustomSizedBox.textSpacingVertical(),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.person_2_outlined,
                                            color: TColors.textGrey,
                                            size: 15.sp,
                                          ),
                                          Text(
                                            ' Mumayaz Allan',
                                            style: CustomTextStyle.greyTextStyle
                                                .apply(fontSizeFactor: 1),
                                          ),
                                        ],
                                      ),
                                      CustomSizedBox.textSpacingVertical(),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.watch_later_outlined,
                                            color: TColors.textGrey,
                                            size: 15.sp,
                                          ),
                                          Text(
                                            '03:00',
                                            style:
                                                CustomTextStyle.greyTextStyle,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.fromLTRB(15.w,4.h,0,0),
                                        child: Text(
                                          '540,000 S.P',
                                          style:
                                              CustomTextStyle.greyTextStyle.apply(
                                            fontSizeFactor: 1.2,
                                            color: TColors.primary,
                                          ),
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
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
