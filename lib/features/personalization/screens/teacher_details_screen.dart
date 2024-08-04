import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/utils/constants/image_strings.dart';
import 'package:sizer/sizer.dart';

class TeacherDetailsScreen extends StatelessWidget {
  const TeacherDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Our Teachers',
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
            color: TColors.primary,
            fontFamily: 'Cairo',
          ),
        ),
        backgroundColor: Colors.white,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10.sp),
                      ),
                      child: Image.asset(
                        TImages.teacher_female,
                        width: 50.w,
                        height: 30.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 35.w,
                      height: 30.h,
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: TColors.primary,
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10.sp),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '5 Years',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo'),
                          ),
                          Text(
                            'Experience',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontFamily: 'Cairo'),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '32',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo'),
                          ),
                          Text(
                            'Courses',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontFamily: 'Cairo'),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '150',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo'),
                          ),
                          Text(
                            'Students',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontFamily: 'Cairo'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  'Ms. Ghinwa Alkanj',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Master at Damascus University\nEnglish Literature\nMaster in English Business\nTesol International Association',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      TImages.certificate,
                      width: 45.w,
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      TImages.certificate,
                      width: 45.w,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
