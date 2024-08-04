import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/constants/image_strings.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  TImages.header_image,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
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
                offset: Offset(0, -35),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center, // تغيير المحاذاة إلى المنتصف
                    children: [
                      Text(
                        'About Us',
                        style: TextStyle(
                          color: TColors.primary,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'The Milestone Institute deals with personalized education for high school students, a field in which we have been a leader since our foundation in 2010. Our English-language programs, which can be completed alongside an internationally recognized high school developed in Hungary, serve the intellectual development of our students, so that they can find the most suitable field for their interests and abilities and thus become successful, independent thinking individuals. The goal of our unique educational program is to cultivate future leaders who are the leaders of the 21st century. They were meant to create a competitive Hungary in the 20th century.',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 13.sp,
                          height: 1.5,
                          fontFamily: 'Cairo'
                        ),
                        textAlign: TextAlign.center, // جعل النص في المنتصف
                      ),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
