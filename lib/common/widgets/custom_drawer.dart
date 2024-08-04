import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import '../../features/personalization/screens/about_us_screen.dart';
import '../../features/personalization/screens/contact_info_screen.dart';
import '../../features/personalization/screens/our_teachers_screen.dart';
import '../../utils/constants/image_strings.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero
      ),
      child: Column(
        children: [
          SizedBox(height: 5.h),
          Container(
            height: 15.h,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: FittedBox(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(TImages.user2),
                    radius: 30,
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ghinwa Alkanj",
                        style: TextStyle(
                          color: TColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Information Technology Engineer",
                        style: TextStyle(
                          color: TColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              "MENU",
              style: TextStyle(
                fontSize: 10.sp,
                color: TColors.darkGrey,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          Divider(
            endIndent: 5.w,
            indent: 5.w,
            color: TColors.buttonDisabled,
            height: 0.h,
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: TColors.primary,
            ),
            title: Text(
              "Favorites",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: TColors.primary,
                fontFamily: 'Cairo',
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: TColors.primary,
            ),
            title: Text(
              "About Us",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: TColors.primary,
                fontFamily: 'Cairo',
              ),
            ),
            onTap: () {
              Get.to(AboutUsScreen());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.people,
              color: TColors.primary,
            ),
            title: Text(
              "Our Teachers",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: TColors.primary,
                fontFamily: 'Cairo',
              ),
            ),
            onTap: () {
              Get.to(OurTeachersScreen());

            },
          ),
          ListTile(
            leading: Icon(
              Icons.policy,
              color: TColors.primary,
            ),
            title: Text(
              "Privacy & Policy",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: TColors.primary,
                fontFamily: 'Cairo',
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.contact_phone,
              color: TColors.primary,
            ),
            title: Text(
              "Contact Info",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: TColors.primary,
                fontFamily: 'Cairo',
              ),
            ),
            onTap: () {
              Get.to(ContactInfoScreen());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person_add,
              color: TColors.primary,
            ),
            title: Text(
              "Invite Friends",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: TColors.primary,
                fontFamily: 'Cairo',
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "SETTINGS",
              style: TextStyle(
                fontSize: 10.sp,
                color: TColors.darkGrey,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          Divider(
            endIndent: 5.w,
            indent: 5.w,
            color: TColors.buttonDisabled,
            height: 0.h,
          ),
          ListTile(
            leading: Icon(
              Icons.brightness_6,
              color: TColors.primary,
            ),
            title: Text(
              "Dark Mode",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: TColors.primary,
                fontFamily: 'Cairo',
              ),
            ),
            trailing: Switch(
              value: false,
              onChanged: (value) {},
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.language,
              color: TColors.primary,
            ),
            title: Text(
              "Language",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: TColors.primary,
                fontFamily: 'Cairo',
              ),
            ),
            trailing: Switch(
              value: false,
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
