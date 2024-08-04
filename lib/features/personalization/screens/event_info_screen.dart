import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/utils/constants/image_strings.dart';
import 'package:sizer/sizer.dart';

import '../../../common/widgets/colored_app_bar.dart';

class EventInfoScreen extends StatelessWidget {
  const EventInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Event Info',
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
            ])),
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 25.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                      image: DecorationImage(
                        image: AssetImage(TImages.events1),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Text(
                      'GREAT CHAMPION LEAGUE',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: TColors.primary,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.thumb_up_alt_rounded,
                      color: TColors.primary,
                      size: 20.sp,
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: TColors.textGrey,
                      size: 15.sp,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      'AL WEHDA CLUB',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: TColors.textGrey,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Container(
                  width: 100.w,
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: TColors.primary.withOpacity(0.10),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          Text(
                            'Day',
                            style: TextStyle(
                              color: TColors.textGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  color: TColors.primary),
                              SizedBox(width: 1.w),
                              Text(
                                'Friday',
                                style: TextStyle(color: TColors.primary),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          Text(
                            'Date',
                            style: TextStyle(
                              color: TColors.textGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Icon(Icons.date_range, color: TColors.primary),
                              SizedBox(width: 1.w),
                              Text(
                                '01-03-2024',
                                style: TextStyle(color: TColors.primary),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          Text(
                            'Time',
                            style: TextStyle(
                              color: TColors.textGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              Icon(Icons.watch_later_outlined,
                                  color: TColors.primary),
                              SizedBox(width: 1.w),
                              Text(
                                '4:00 pm',
                                style: TextStyle(color: TColors.primary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'About This Event',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary,
                      fontFamily: 'Cairo'),
                ),
                SizedBox(height: 1.h),
                Text(
                  'The Milestone legends are one step forward toward reaching their desired goal, you made me me proud keep up the hard work The Milestone legends are one step forward toward reaching their desired goal, you made me me proud keep up the hard work',
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: TColors.textGrey,
                      fontFamily: 'Cairo'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
