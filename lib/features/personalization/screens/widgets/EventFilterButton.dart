import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';

class EventFilterButton extends StatelessWidget {
  final String label;
  final int index;

  //final RxInt selectedFilterIndex;
  final Function(int) onTap;

  EventFilterButton({
    required this.label,
    required this.index,
    // required this.selectedFilterIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isActive = true;
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Column(
        children: [
         Container(
           height: 5.h,
           width: 25.w,
           margin: EdgeInsets.only(left: 2.w),
           alignment: Alignment.center,
           decoration: BoxDecoration(
             border: Border.all(color: TColors.primary,width: 0.8.w),
             borderRadius: BorderRadius.circular(15.sp)
           ),
           child:    Text(
             label,
             textAlign: TextAlign.center,
             style: CustomTextStyle.greyTextStyle.apply(
                 color: isActive ? TColors.grey : TColors.black,
                 fontSizeFactor: 1.3),
           ),
         ),

        ],
      ),
    );
  }
}
