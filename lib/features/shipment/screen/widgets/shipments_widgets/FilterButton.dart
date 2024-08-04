import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';

class CustomFilterButton extends StatelessWidget {
  final String image;
  final String label;
  final int index;

  //final RxInt selectedFilterIndex;
  final Function(int) onTap;

  CustomFilterButton({
    required this.image,
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
          CircleAvatar(
            backgroundColor:
                isActive ? Colors.transparent : TColors.grey.withOpacity(0.5),
            radius: 5.h,
            child: Image.asset(image),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: CustomTextStyle.greyTextStyle.apply(
                color: isActive ? TColors.white : TColors.black,
                fontSizeFactor: 0.9),
          ),
        ],
      ),
    );
  }
}
