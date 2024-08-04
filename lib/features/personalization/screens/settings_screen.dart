import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/features/personalization/screens/privacy_policy_screen.dart';
import 'package:shipment_merchent_app/features/personalization/screens/profile_screen.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/EventFilterButton.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/settings_widgets/setting_section.dart';
import 'package:shipment_merchent_app/features/personalization/screens/about_screen.dart';
import 'package:shipment_merchent_app/common/widgets/custom_list_tile.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/section_title.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/utils/constants/image_strings.dart';
import 'package:sizer/sizer.dart';
import '../../../common/styles/custom_textstyle.dart';
import '../../../common/widgets/colored_app_bar.dart';
import '../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../address/viewAddress.dart';
import '../../home/controller/home_controller.dart';
import '../../shipment/screen/widgets/shipments_widgets/FilterButton.dart';
import '../controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    final SettingsController settingsController = Get.put(SettingsController());

    return Scaffold(
      appBar: const TCAppBar(
        title: 'Events',
        showBackArrow: false,
      ),
      backgroundColor: TColors.bg,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      EventFilterButton(
                        label: '2024',
                        index: 0,
                        onTap: (index) {},
                      ),
                      EventFilterButton(
                        label: '2023',
                        index: 1,
                        onTap: (index) {},
                      ),
                      EventFilterButton(
                        label: '2022',
                        index: 2,
                        onTap: (index) {},
                      ),
                      EventFilterButton(
                        label: '2021',
                        index: 3,
                        onTap: (index) {},
                      ),
                      EventFilterButton(
                        label: '2020',
                        index: 4,
                        onTap: (index) {},
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 57.h,
                width: 100.w,
                child: ListView.builder(
                  padding: EdgeInsets.all(5.w),
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 6.w),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          height: 40.h,
                          width: 80.w,
                          padding: EdgeInsets.only(left: 5.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.sp),
                            color: TColors.white,
                            boxShadow: [
                              BoxShadow(
                                color: TColors.black.withOpacity(0.25),
                                blurRadius: 8,
                                spreadRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 25.h,
                                width: 80.w,
                                margin: EdgeInsets.only(top: 2.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.sp),
                                  image: DecorationImage(
                                      image: AssetImage(TImages.events1),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 2.h, right: 1.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'CHAMPION LEAGUE',
                                      style: CustomTextStyle.headlineTextStyle
                                          .apply(
                                              fontSizeFactor: 0.7,
                                              color: TColors.primary,
                                              fontSizeDelta: 1.3,
                                              fontWeightDelta: 2),
                                    ),
                                    CustomSizedBox.textSpacingVertical(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '04:00 pm',
                                          style: CustomTextStyle.greyTextStyle,
                                          textDirection: TextDirection.ltr,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Icon(
                                          Icons.watch_later_outlined,
                                          color: TColors.textGrey,
                                          size: 15.sp,
                                        ),
                                      ],
                                    ),
                                    CustomSizedBox.textSpacingVertical(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Whdeh club Playground',
                                          style: CustomTextStyle.greyTextStyle,
                                          textDirection: TextDirection.ltr,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Icon(
                                          Icons.map_outlined,
                                          color: TColors.textGrey,
                                          size: 15.sp,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
