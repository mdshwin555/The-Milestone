import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/about_widgets/section_logo.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/about_widgets/section_title.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/contact_us_widgets/contact_detail.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controller/contact_us_controller.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ContactInfoController contactInfoController = Get.put(ContactInfoController());

    return Scaffold(
      appBar: const TAppBar(
        title: 'تواصل معنا',
        showBackArrow: true,
      ),
      backgroundColor: TColors.bg,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AboutSectionLogo(),
              AboutSectionTitle(title: 'جهات الاتصال'),
              SizedBox(height: 2.h),
              Expanded(
                child: Obx(() {
                  if (contactInfoController.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: TColors.primary,
                      ),
                    );
                  } else if (contactInfoController.contactInfoList.isEmpty) {
                    return Center(
                      child: Text(
                        'لا توجد جهات اتصال متاحة حالياً.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: TColors.darkGrey,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: contactInfoController.contactInfoList
                          .map((contact) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: ContactDetail(
                          icon: getIconForContactType(contact.type),
                          detail: contact.value,
                          type: contact.type,
                        ),
                      ))
                          .toList(),
                    );
                  }
                }),
              ),
              SizedBox(height: 2.h),
              Center(
                child: Text(
                  'جميع الحقوق محفوظة لشركة Kwickly ©',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: TColors.darkGrey,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData getIconForContactType(String type) {
    switch (type) {
      case 'phone':
        return FontAwesomeIcons.phoneAlt;
      case 'whatsapp':
        return FontAwesomeIcons.whatsapp;
      case 'telegram':
        return FontAwesomeIcons.telegramPlane;
      case 'facebook':
        return FontAwesomeIcons.facebook;
      case 'website':
        return FontAwesomeIcons.globe;
      case 'instagram':
        return FontAwesomeIcons.instagram;
      case 'email':
        return FontAwesomeIcons.envelope;
      default:
        return FontAwesomeIcons.addressBook;
    }
  }
}

