import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  final formKey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  final Crud crud = Get.find<Crud>();

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      phoneNumber.value = Get.arguments['phoneNumber'] ?? '';
      verificationCode = Get.arguments['verificationCode'] ?? '';
      _storeArgumentsInPreferences();
    } else {
      _loadArgumentsFromPreferences();
    }
    startCountdown();
  }

  @override
  void onClose() {
    _timer?.cancel();
    pinController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void updateCode(String value) {
    code.value = value;
  }

  void verifyCode() async {
    if (code.value.length == 5) {
      isLoading.value = true;
      var response = await crud.postData(
        VerifyEndpoint,
        {
          'phone': phoneNumber.value,
          'verification_code': code.value,
        },
        {},
      );
      isLoading.value = false;
      response.fold(
            (failure) {
          errorMessage.value = 'فشل في الاتصال بالخادم، أعد المحاولة';
          Get.snackbar(
            'خطأ',
            'فشل في الاتصال بالخادم، أعد المحاولة',
            backgroundColor: TColors.error,
            colorText: TColors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            icon: Icon(Icons.error_outline, color: TColors.white),
          );
        },
            (data) async {
          VerifyResponseModel verifyResponse = VerifyResponseModel.fromJson(data);
          if (verifyResponse.status) {
            await SharedPreferencesHelper.setString('token', verifyResponse.token);
            await SharedPreferencesHelper.setInt('user_id', verifyResponse.userId);
            String? token = await SharedPreferencesHelper.getString('token');
            int? userId = await SharedPreferencesHelper.getInt('user_id');
            if (token != null && userId != null) {
              print('verifyToken: $token, User ID: $userId');
            } else {
              print('No token or user_id found');
            }

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('isAuth', true);
            print(prefs.getBool('isAuth'));

            // Store verifyResponse data in SharedPreferences
            await prefs.setString('name', verifyResponse.name ?? '');
            await prefs.setString('national_id', verifyResponse.nationalId ?? '');
            await prefs.setString('business_name', verifyResponse.businessName ?? '');
            await prefs.setString('gender', verifyResponse.gender ?? '');

            Get.to(() => PersonalInfoScreen(), arguments: {
              'name': verifyResponse.name ?? '',
              'national_id': verifyResponse.nationalId ?? '',
              'business_name': verifyResponse.businessName ?? '',
              'gender': verifyResponse.gender ?? '',
            });
          } else {
            errorMessage.value = 'رمز التحقق غير صحيح';
            Get.snackbar('Error', 'رمز التحقق غير صحيح');
          }
        },
      );
    } else {
      errorMessage.value = 'يرجى إدخال رمز التحقق المكون من 5 أرقام';
    }
  }

  void resendCode() async {
    var response = await crud.postData(
      '${MerchantAPIKey}auth/login.php',
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

        verificationCode = loginResponse.verificationCode;
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
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    resendCountdown.value = 59;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _storeArgumentsInPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', phoneNumber.value);
    await prefs.setString('verificationCode', verificationCode ?? '');
  }

  Future<void> _loadArgumentsFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNumber.value = prefs.getString('phoneNumber') ?? '';
    verificationCode = prefs.getString('verificationCode');
  }
}
