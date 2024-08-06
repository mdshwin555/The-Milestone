import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../update_screen.dart';
import '../../auth/screen/login_screen.dart';
import '../../../navigation_menu.dart'; // Import the NavigationMenu for redirection

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  final pageController = PageController();
  var currentPageIndex = 0.obs;
  late SharedPreferences prefs;

  @override
  void onInit() {
    super.onInit();
    checkIfFirstTime();
    checkForUpdates();
  }

  Future<void> checkIfFirstTime() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> checkForUpdates() async {
    try {
      String osType = GetPlatform.isAndroid ? 'Android' : 'iOS';

      var request = http.MultipartRequest('POST', Uri.parse('https://darkred-wombat-762943.hostingersite.com/Kwickly/merchant/get_update.php'));
      request.fields.addAll({
        'user_type': 'merchant',
        'os_type': osType,
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var data = json.decode(responseBody);

        if (data['status']) {
          var updates = data['updates'];
          if (updates.isNotEmpty) {
            var latestUpdate = updates[0];
            var latestVersion = latestUpdate['update_number'];
            var currentVersion = await _getCurrentVersion();

            if (_isNewerVersion(latestVersion, currentVersion)) {
              _showUpdateScreen(latestUpdate);
              return;
            }
          }
        }
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }

    // إذا لم يكن هناك تحديث متاح أو كانت النسخة الحالية هي الأحدث، انتقل إلى الشاشة الرئيسية
    _navigateToMainScreen();
  }

  Future<String> _getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print('/////////////////////////////');
    print(packageInfo.version);
    return packageInfo.version;
  }

  bool _isNewerVersion(String latestVersion, String currentVersion) {
    List<String> latestParts = latestVersion.split('.');
    List<String> currentParts = currentVersion.split('.');

    for (int i = 0; i < latestParts.length; i++) {
      if (int.parse(latestParts[i]) > int.parse(currentParts[i])) {
        return true;
      } else if (int.parse(latestParts[i]) < int.parse(currentParts[i])) {
        return false;
      }
    }
    return false;
  }

  void _showUpdateScreen(Map<String, dynamic> updateData) {
    Get.offAll(() => UpdateScreen(updateData: updateData));
  }

  void _navigateToMainScreen() {
    Get.offAll(() => NavigationMenu());
  }

  void updatePageIndicator(index) => currentPageIndex.value = index;

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage() {
    if (currentPageIndex.value < 2) {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
      currentPageIndex.value = page;
    } else {
      prefs.setBool('isFirstTime', false);
      print(prefs.getBool('isFirstTime'));
      Get.offAll(() => const LoginScreen());
    }
  }

  void previousPage() {
    if (currentPageIndex.value > 0) {
      int page = currentPageIndex.value - 1;
      pageController.jumpToPage(page);
      currentPageIndex.value = page;
    }
  }
}
