import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/features/personalization/screens/privacy_policy_screen.dart';
import 'package:shipment_merchent_app/features/personalization/screens/profile_screen.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/settings_widgets/setting_section.dart';
import 'package:shipment_merchent_app/features/personalization/screens/about_screen.dart';
import 'package:shipment_merchent_app/common/widgets/custom_list_tile.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/section_title.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import '../../address/controller/AddressController.dart';
import '../../address/viewAddress.dart';
import '../../home/controller/home_controller.dart';
import '../controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    final SettingsController settingsController = Get.put(SettingsController());

    return Scaffold(
      appBar: TAppBar(
        title: 'الإعدادات',
        showBackArrow: false,
      ),
      backgroundColor: TColors.bg,
      body: WillPopScope(
        onWillPop: () => controller.onWillPop(context),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 0, left: 4.w, right: 4.w, bottom: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSizedBox.itemSpacingVertical(),
                  const SectionTitle(title: 'الحساب'),
                  CustomSettingsSection(
                    children: [
                      CustomListTile(
                        title: 'المعلومات الشخصية',
                        icon: Iconsax.profile_circle,
                        onTap: () {
                          Get.to(() => ProfileScreen());
                        },
                      ),
                      CustomListTile(
                        title: 'العناوين',
                        icon: Iconsax.map,
                        onTap: () {
                          Get.to(() => AddressListScreen());
                        },
                      ),
                    ],
                  ),
                  CustomSizedBox.itemSpacingVertical(),
                  const SectionTitle(title: 'التفضيلات'),
                  CustomSettingsSection(
                    children: [
                      CustomListTile(
                        title: 'الوضع الليلي',
                        icon: Iconsax.moon,
                        trailing: Obx(() => Switch(
                          activeColor: TColors.primary,
                          value: settingsController.isDarkMode.value,
                          onChanged: (value) {
                            settingsController.toggleDarkMode(value);
                          },
                        )),
                      ),
                      CustomListTile(
                        title: 'الإشعارات',
                        icon: Iconsax.notification,
                        trailing: Obx(() => Switch(
                          activeColor: TColors.primary,
                          value: settingsController.isNotificationsEnabled.value,
                          onChanged: (value) {
                            settingsController.toggleNotifications(value);
                          },
                        )),
                      ),
                    ],
                  ),
                  CustomSizedBox.itemSpacingVertical(),
                  const SectionTitle(title: 'معلومات عامة'),
                  CustomSettingsSection(
                    children: [
                      CustomListTile(
                        title: 'حول التطبيق',
                        icon: Icons.info_outline_rounded,
                        onTap: () {
                          Get.to(AboutAppScreen());
                        },
                      ),
                      CustomListTile(
                        title: 'سياسة الخصوصية',
                        icon: Icons.privacy_tip_outlined,
                        onTap: () {
                          Get.to(PrivacyPolicyScreen());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
