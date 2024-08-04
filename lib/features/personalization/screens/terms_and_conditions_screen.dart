import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/terms_and_conditions_widgets/terms_section_content.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/terms_and_conditions_widgets/terms_section_title.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: 'Terms and Conditions',
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
              children: const [
                TermsSectionTitle(title: 'Introduction'),
                TermsSectionContent(content: 'Welcome to the Milestone app . By using this app, you agree to comply with the following terms and conditions.'),
                TermsSectionTitle(title: 'App Usage'),
                TermsSectionContent(content: 'You must use this app in a legal and appropriate manner in accordance with all applicable laws and regulations.'),
                TermsSectionTitle(title: 'Intellectual Property Rights'),
                TermsSectionContent(content: 'All rights related to the content, software, and technology used in this app are owned by "Milestone" or its licensors.'),
                TermsSectionTitle(title: 'Liability'),
                TermsSectionContent(content: 'We are not responsible for any losses or damages arising from your use of this app.'),
                TermsSectionTitle(title: 'Changes to Terms and Conditions'),
                TermsSectionContent(content: 'We reserve the right to modify these terms and conditions at any time. You will be notified of any changes by posting the new terms on the app.'),
                TermsSectionTitle(title: 'Contact Us'),
                TermsSectionContent(content: 'If you have any questions or inquiries about these terms and conditions, please contact us via email at: support@milestone.com.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
