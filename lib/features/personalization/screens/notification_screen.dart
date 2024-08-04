import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/utils/constants/image_strings.dart';
import 'package:sizer/sizer.dart';
import '../../../common/styles/custom_textstyle.dart';
import '../../../common/widgets/colored_app_bar.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../home/controller/home_controller.dart';
import '../controller/notification_controller.dart';
import 'book_placement_test_screen.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());
  final HomeController controller1 = Get.put(HomeController());

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TCAppBar(
        title: 'Placement Test',
        showBackArrow: false,
      ),
      backgroundColor: TColors.bg,
      body: WillPopScope(
        onWillPop: () => controller1.onWillPop(context),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
            padding: EdgeInsets.all(5.w),
            itemCount: 2,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              List<dynamic> shipment = [];
              return Container(
                height: 28.h,
                padding: EdgeInsets.only(top: 6.w),
                child: GestureDetector(
                  onTap: () {
                    // Get.to(TrackingScreen(
                    //     shipmentId: shipment.shipmentId));
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        left: 2.w,
                        child: Container(
                          height: 23.h,
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
                                image: AssetImage(TImages.placement),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 5.w,
                        top: 2.h,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Container(
                            padding: EdgeInsets.only(left: 5.w),
                            height: 19.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.sp),
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
                                      EdgeInsets.only(top: 2.h, right: 6.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'English',
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
                                            Icons.date_range,
                                            color: TColors.textGrey,
                                            size: 15.sp,
                                          ),
                                          Text(
                                            '11/04/2024',
                                            style:
                                                CustomTextStyle.greyTextStyle,
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
                                      CustomSizedBox.textSpacingVertical(
                                          height: 0.2.h),
                                      Container(
                                        width: 34.w,
                                        height: 4.3.h,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Get.to(BookPlacementTestScreen());
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: TColors.primary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                            'Book ',
                                            style: CustomTextStyle
                                                .headlineTextStyle
                                                .apply(
                                                    color: TColors.white,
                                                    fontSizeFactor: 0.8),
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
