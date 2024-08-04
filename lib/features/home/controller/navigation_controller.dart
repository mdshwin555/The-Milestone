import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/features/personalization/screens/notification_screen.dart';
import 'package:shipment_merchent_app/features/personalization/screens/settings_screen.dart';
import '../../Qr_code/screen/Qr_code_scan.dart';
import '../../shipment/screen/shipments_screen.dart';
import '../screen/home_screen.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 2.obs;
  final screens = [
    SettingsScreen(),
    NotificationScreen(),
    ShipmentScreen(),
    BarcodeScanScreen(onBarcodeScanned: (String barcode) {  },),
    HomeScreen(),
  ];
  final outlineIcons = [
    Icons.celebration_outlined,
    Icons.quiz_outlined,
    Iconsax.home,
    Icons.qr_code_scanner_sharp,
    Icons.menu_book_sharp,
  ];
  List bottomnavigationbaritems = [
    'Events',
    'Placement Test',
    'Home',
    'Qr Scanner',
    'My Course',
  ];
}
