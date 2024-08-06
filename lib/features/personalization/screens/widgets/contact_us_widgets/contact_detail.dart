import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/constants/colors.dart';

class ContactDetail extends StatelessWidget {
  final IconData icon;
  final String detail;
  final String type;

  const ContactDetail({
    Key? key,
    required this.icon,
    required this.detail,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: TColors.primary,
          size: 20.sp,
        ),
        SizedBox(width: 2.w),
        Text(
          type == 'phone' || type == 'whatsapp' ? _formatJordanianPhoneNumber(detail) : detail,
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 12.sp,
            color: TColors.darkGrey,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

String _formatJordanianPhoneNumber(String phoneNumber) {
  // تأكد أن الرقم يبدأ برمز الدولة +962
  if (phoneNumber.startsWith('+962')) {
    // قم بتقسيم الرقم إلى أجزاء للتنسيق
    String countryCode = '+962';
    String part1 = phoneNumber.substring(4, 5);
    String part2 = phoneNumber.substring(5, 8);
    String part3 = phoneNumber.substring(8, 11);
    return '$countryCode $part1 $part2 $part3';
  } else {
    // إذا لم يبدأ برمز الدولة، أعد الرقم كما هو
    return phoneNumber;
  }
}