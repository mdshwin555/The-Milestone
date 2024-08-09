import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';

class ContactInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  TImages.map_image,
                  width: double.infinity,
                  height: 30.h,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: TColors.primary,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Transform.translate(
                offset: Offset(0, -50), // رفع المربع قليلاً للأعلى
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Contact Info',
                          style: TextStyle(
                            color: TColors.primary,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              color: TColors.primary,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Themilestone.ltc@gmail.com',
                              style: TextStyle(
                                color: TColors.primary,
                                fontSize: 13.sp,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(
                              Icons.phone_android,
                              color: TColors.primary,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8),
                            Text(
                              '+963 936 118 114',
                              style: TextStyle(
                                  color: TColors.primary,
                                  fontSize: 13.sp,
                                  fontFamily: 'Cairo'),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(
                              Icons.phone_android,
                              color: TColors.primary,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8),
                            Text(
                              '+963 936 118 115',
                              style: TextStyle(
                                color: TColors.primary,
                                fontSize: 13.sp,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: TColors.primary,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8),
                            Text(
                              '011-4415555',
                              style: TextStyle(
                                color: TColors.primary,
                                fontSize: 13.sp,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -15.h),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 25.sp,
                      backgroundColor: TColors.primary,
                      child: Icon(Icons.send, color: Colors.white, size: 30),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Follow Us On',
                      style: TextStyle(
                          color: TColors.textPrimary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo'),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(TImages.facebook),
                        SizedBox(
                          width: 2.w,
                        ),
                        Image.asset(TImages.telegram),
                        SizedBox(
                          width: 3.w,
                        ),
                        Image.asset(TImages.instagram),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
