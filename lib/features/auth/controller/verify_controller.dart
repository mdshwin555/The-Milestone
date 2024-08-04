import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/colors.dart';
import '../model/login_model.dart';
import '../model/verify_model.dart';
import '../screen/personal_info_screen.dart';

class VerifyController extends GetxController {
  var code = ''.obs;
  var errorMessage = ''.obs;
  var phoneNumber = ''.obs;
  var verificationCode;
  var resendCountdown = 59.obs;
  var isLoading = false.obs;

  final formKey = GlobalKey<FormState>(); // Add this line
  final pinController = TextEditingController(); // Add this line
  final focusNode = FocusNode(); // Add this line

  final Crud crud = Get.find<Crud>();

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      phoneNumber.value = Get.arguments['phoneNumber'] ?? '';
      verificationCode = Get.arguments['verificationCode'] ?? '';
    }
    startCountdown();
  }

  @override
  void onClose() {
    _timer?.cancel();
    pinController.dispose(); // Add this line
    focusNode.dispose(); // Add this line
    super.onClose();
  }

  void updateCode(String value) {
    code.value = value;
  }

  void verifyCode() async {
    if (code.value.length == 5) {
      isLoading.value = true;

      // التحقق إذا كان الكود يساوي 11111
      if (code.value == '11111') {
        isLoading.value = false;
        Get.to(() => PersonalInfoScreen(), arguments: {
          'name': 'Sample Name',
          'national_id': 'Sample National ID',
          'business_name': 'Sample Business Name',
          'gender': 'Sample Gender',
        });
      } else {
        isLoading.value = false;
        errorMessage.value = 'رمز التحقق غير صحيح';
        Get.snackbar('Error', 'رمز التحقق غير صحيح');
      }
    } else {
      errorMessage.value = '';
    }
  }

  void resendCode() async {
    var response = await crud.postData(
      '${MerchantAPIKey}auth/login.php', // Ensure this endpoint is correct
      {
        'phone': phoneNumber.value,
      },
      {},
    );

    response.fold(
      (failure) {
        Get.snackbar('Error', 'فشل في إعادة إرسال رمز التحقق');
      },
      (data) {
        LoginResponseModel loginResponse = LoginResponseModel.fromJson(data);

        verificationCode =
            loginResponse.verificationCode; // Update the verificationCode
        Get.snackbar(
          'نجاح',
          'رمز التحقق الجديد هو: ${loginResponse.verificationCode}',
          backgroundColor: TColors.primary,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          icon: Icon(Icons.check_circle_outline, color: Colors.white),
          duration: Duration(seconds: 5),
        );
        startCountdown();
      },
    );
  }

  void startCountdown() {
    resendCountdown.value = 59;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
      } else {
        timer.cancel();
      }
    });
  }
}
