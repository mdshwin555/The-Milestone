import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/features/personalization/screens/profile_screen.dart';
import 'package:shipment_merchent_app/utils/constants/image_strings.dart';
import 'package:sizer/sizer.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../shipment/screen/bulk_shipments_screen.dart';
import '../../../shipment/screen/widgets/shipments_widgets/FilterButton.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    Key? key,
    required this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.showSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
  }) : super(key: key);

  final String title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final bool showSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          Container(
            height: 50.h,
            decoration: BoxDecoration(
                color: TColors.primary,
                borderRadius: BorderRadius.circular(20.sp),
                image: DecorationImage(
                  image: AssetImage(TImages.wallpaper),
                  fit: BoxFit.fill,
                )),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 7.h,
                  ),
                  Container(
                    width: 90.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Have a fulfilling day of with us!',
                              style: TextStyle(color: Colors.white, fontSize: 11.sp),
                            ),
                            Text(
                              'Ghinwa Alkanj',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                Icon(Icons.notifications_none_outlined,
                                    color: Colors.white, size: 20.sp),
                                Positioned(
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 12,
                                      minHeight: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                Get.to(ProfileScreen());
                              },
                              child: CircleAvatar(
                                backgroundImage: AssetImage(TImages.user),
                                radius: 15.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  TSearchContainer(
                    text: "search for courses, events and ads",
                    onTap: () {
                      //Get.to(SearchScreen());
                    },
                  ),
                  Container(
                    width: 95.w,
                    padding: EdgeInsets.fromLTRB(3.w, 2.h, 0, 1.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'services',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: TColors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Cairo",
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CustomFilterButton(
                                image: TImages.TESOL,
                                label: 'TESOL',
                                index: 0,
                                onTap: (index) {},
                              ),
                              CustomFilterButton(
                                image: TImages.IELTS,
                                label: 'IELTS',
                                index: 1,
                                onTap: (index) {},
                              ),
                              CustomFilterButton(
                                image: TImages.TOT,
                                label: 'TOT',
                                index: 2,
                                onTap: (index) {},
                              ),
                              CustomFilterButton(
                                image: TImages.LEVELS,
                                label: 'LEVELS',
                                index: 3,
                                onTap: (index) {},
                              ),
                              CustomFilterButton(
                                image: TImages.BUSINESS,
                                label: 'BUSINESS',
                                index: 4,
                                onTap: (index) {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(25.h);
}



