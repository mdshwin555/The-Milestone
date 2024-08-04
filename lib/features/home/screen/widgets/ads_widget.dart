import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_fade/image_fade.dart';
import 'package:shipment_merchent_app/utils/constants/image_strings.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RxInt _currentAdIndex = 0.obs;

    Timer.periodic(const Duration(seconds: 5), (Timer timer) {

        _currentAdIndex.value =
            (_currentAdIndex.value + 1) % 3;

    });

    // قائمة الصور من assets
    final List<String> localAds = [
      TImages.ads1,
      TImages.ads2,
      TImages.events1,
    ];

    return Column(
      children: [
        Container(
          width: 100.w,
          height: 25.h,
          padding: EdgeInsets.fromLTRB(5.w, 3.h, 5.w, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.sp),
            child: Obx(() {
              final imageUrl = localAds[_currentAdIndex.value];
              return ImageFade(
                image: AssetImage(imageUrl),
                duration: const Duration(milliseconds: 900),
                syncDuration: const Duration(milliseconds: 150),
                alignment: Alignment.center,
                fit: BoxFit.cover,
                placeholder: Container(
                  color: const Color(0xFFCFCDCA),
                  alignment: Alignment.center,
                  child: const Icon(Icons.photo,
                      color: Colors.white30, size: 128.0),
                ),
                loadingBuilder: (context, progress, chunkEvent) =>
                    Center(child: CircularProgressIndicator(value: progress)),
                errorBuilder: (context, error) => Container(
                  color: const Color(0xFF6F6D6A),
                  alignment: Alignment.center,
                  child: const Icon(Icons.warning,
                      color: Colors.black26, size: 128.0),
                ),
              );
            }),
          ),
        ),
        CustomSizedBox.itemSpacingVertical(),
      ],
    );
  }
}
