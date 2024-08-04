import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';

class CourseInfoScreen extends StatelessWidget {
  const CourseInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Course Info',
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
            color: TColors.primary,
            fontFamily: 'Cairo',
          ),
        ),
        backgroundColor: TColors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: TColors.primary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: TColors.bg,
      body: Container(
        height: 100.h,
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
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 25.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp),
                          image: DecorationImage(
                            image: AssetImage(TImages.course_info),
                            // استخدم الصورة المناسبة
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 24.sp,
                        ),
                      ),
                      Positioned(
                        bottom: -15.h, // رفع المستطيل للأعلى قليلاً
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Container(
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  TColors.primary,
                                  TColors.primary.withOpacity(0.7),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15.sp),
                              boxShadow: [
                                BoxShadow(
                                  color: TColors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'English Language Course',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  'By Prof Mumayaz Allan                         Price: 450,000 S.P',
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    color: Colors.white,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                Divider(
                                  indent: 2.w,
                                  endIndent: 2.w,
                                ),
                                SizedBox(height: 1.h),
                                Row(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.access_time,
                                            color: Colors.white),
                                        SizedBox(width: 1.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Time',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10.sp,
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                            SizedBox(width: 1.w),
                                            Text(
                                              '05:00 PM',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.sp,
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.bar_chart,
                                            color: Colors.white),
                                        SizedBox(width: 1.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Level',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10.sp,
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                            SizedBox(width: 1.w),
                                            Text(
                                              '2B Level',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.sp,
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.calendar_today,
                                            color: Colors.white),
                                        SizedBox(width: 1.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Days',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10.sp,
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                            SizedBox(width: 1.w),
                                            Text(
                                              '3 Days',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.sp,
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 17.h), // تعديل المسافة بعد المستطيل
                Text(
                  'About This Course',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: TColors.primary,
                    fontFamily: 'Cairo',
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'English Language Proficiency 2B is an intermediate-level course designed to further develop students\' English language skills in reading, writing, listening, and speaking. Building upon the foundations established in English 2A, this course emphasizes communication in real-life situations and expands vocabulary and grammar knowledge.',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: TColors.textGrey,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
