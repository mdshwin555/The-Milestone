import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/utils/constants/image_strings.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/constants/colors.dart';
import '../../features/shipment/screen/bulk_shipments_screen.dart';

class TCAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TCAppBar({
    Key? key,
    required this.title,
    this.showBackArrow = false,
    this.isProfile = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.showSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
  }) : super(key: key);

  final String title;
  final bool showBackArrow;
  final bool isProfile;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final bool showSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 28.h,
        width: 100.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            image: DecorationImage(
                image: AssetImage(TImages.tcappbar), fit: BoxFit.fill)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 5.h,
              right: 5.w,
              child: Row(
                children: [
                  if (showBackArrow)
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 21.sp,
                        color: TColors.white,
                      ),
                    ),
                  if (!showBackArrow) SizedBox(width: 2.w),
                  CustomSizedBox.itemSpacingHorizontal(),
                ],
              ),
            ),
            Positioned(
              top: 6.h,
              child: Text(
                title,
                style: CustomTextStyle.headlineTextStyle.apply(
                  fontWeightDelta: 4,
                  fontSizeFactor: 1.2,
                  color: TColors.white,
                ),
              ),
            ),
            isProfile?Positioned(
              top: 19.h,
              left: 10.w,
              child: CircleAvatar(
                backgroundImage: AssetImage(TImages.user),
                radius: 27.sp,
              ),
            ):SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(25.h);
}
