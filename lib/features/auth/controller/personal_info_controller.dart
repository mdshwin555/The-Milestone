import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/colors.dart';
import '../model/personal_info_model.dart';

class PersonalInfoController extends GetxController {
  var fullName = ''.obs;
  var phoneNumber = ''.obs;
  var nationalId = ''.obs;
  var businessName = ''.obs;
  var gender = ''.obs;
  var address = ''.obs;
  var isFormValid = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController shopController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      fullName.value = Get.arguments['name'] ?? '';
      nationalId.value = Get.arguments['national_id'] ?? '';
      businessName.value = Get.arguments['business_name'] ?? '';
      gender.value = Get.arguments['gender'] ?? '';
      addressController.value = Get.arguments['address'] ?? '';
      validateForm();
    }

    fullNameController = TextEditingController(text: fullName.value);
    idController = TextEditingController(text: nationalId.value);
    shopController = TextEditingController(text: businessName.value);
    genderController = TextEditingController(text: gender.value);
    addressController = TextEditingController(text: address.value);
  }

  void validateForm() {
    if (fullName.value.isNotEmpty &&
        nationalId.value.isNotEmpty &&
        businessName.value.isNotEmpty &&
        gender.value.isNotEmpty &&
        address.value.isNotEmpty &&
        nationalId.value.length == 10) {
      isFormValid.value = true;
    } else {
      isFormValid.value = false;
    }
  }

  void submitPersonalInfo() async {
    if (fullName.value.isEmpty ||
        nationalId.value.isEmpty ||
        businessName.value.isEmpty ||
        gender.value.isEmpty ||
        nationalId.value.length != 10) {
      Get.snackbar(
        'خطأ',
        'يرجى تعبئة جميع المعلومات وتأكد من أن الرقم الوطني يحتوي على 10 أرقام',
        backgroundColor: TColors.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        icon: Icon(Icons.error_outline, color: Colors.white),
        duration: Duration(seconds: 5),
      );
      return;
    }

    isLoading.value = true;
    var token = await SharedPreferencesHelper.getString('token');
    var userId = await SharedPreferencesHelper.getInt('user_id');
    print("personl$token");
    print(userId);
    var response = await crud.postData(
      PersonalInfoEndpoint,
      {
        'token': token,
        'user_id': userId.toString(),
        'name': fullName.value,
        'national_id': nationalId.value,
        'business_name': businessName.value,
        'gender': gender.value,
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
      (data) {
        try {
          PersonalInfoResponseModel responseModel =
              PersonalInfoResponseModel.fromJson(data);
          if (responseModel.status) {
            // Get.to(() => IDUploadScreen(), arguments: {
            //   'id_front_image': responseModel.idFrontImage,
            //   'id_back_image': responseModel.idBackImage,
            // });
          } else {
            Get.snackbar(
              'خطأ',
              responseModel.message ?? 'خطأ غير معروف',
              backgroundColor: TColors.error,
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              margin: EdgeInsets.all(10),
              borderRadius: 10,
              icon: Icon(Icons.error_outline, color: Colors.white),
              duration: Duration(seconds: 5),
            );
          }
        } catch (e) {
          Get.snackbar(
            'خطأ',
            'خطأ في معالجة الاستجابة',
            backgroundColor: TColors.error,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            icon: Icon(Icons.error_outline, color: Colors.white),
            duration: Duration(seconds: 5),
          );
        }
      },
    );
  }
}
