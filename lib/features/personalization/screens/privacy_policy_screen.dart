import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/privacy_policy_widgets/section_content.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/terms_and_conditions_widgets/terms_section_title.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'widgets/section_title.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: 'Privacy Policy',
        showBackArrow: true,
      ),
      backgroundColor: TColors.bg,
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TermsSectionTitle(title: 'Introduction'),
                SectionContent(content: 'We at Milestone are committed to protecting your privacy. This privacy policy applies to all personal data we collect through the app.'),
                TermsSectionTitle(title: 'Information Collection'),
                SectionContent(content: 'We collect personal information you provide when registering on the app or using our services. This may include your name, phone number, address, and other necessary information to provide our services.'),
                TermsSectionTitle(title: 'Use of Information'),
                SectionContent(content: 'We use the information we collect to provide and improve our services. We may use the information to contact you, send updates, and analyze data to understand how our services are used and improve them.'),
                TermsSectionTitle(title: 'Information Sharing'),
                SectionContent(content: 'We will not sell or rent your personal information to any third party without your consent. We may share information with our partners and service providers who assist us in providing our services.'),
                TermsSectionTitle(title: 'Information Security'),
                SectionContent(content: 'We take necessary security measures to protect your personal information from unauthorized access, alteration, or disclosure. However, we cannot guarantee complete security of data transmitted over the internet.'),
                TermsSectionTitle(title: 'Changes to Privacy Policy'),
                SectionContent(content: 'We may update this privacy policy from time to time. We will notify you of any changes by posting the new policy on the app.'),
                TermsSectionTitle(title: 'Contact Us'),
                SectionContent(content: 'If you have any questions or concerns about this privacy policy, please contact us via email at: support@milestone.com.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
