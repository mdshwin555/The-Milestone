import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/core/services/storage_service.dart';
import 'package:shipment_merchent_app/navigation_menu.dart';
import 'package:shipment_merchent_app/utils/constants/api_constants.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import '../model/id_upload_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:image/image.dart' as img;

class IDUploadController extends GetxController {
  var isLoading = false.obs;
  var isFrontLoading = false.obs;
  var isBackLoading = false.obs;
  var frontUploadProgress = 0.0.obs;
  var backUploadProgress = 0.0.obs;
  var idFrontImage = File('').obs;
  var idBackImage = File('').obs;
  var idFrontImageUrl = ''.obs;
  var idBackImageUrl = ''.obs;
  var errorMessage = ''.obs;
  final ImagePicker _picker = ImagePicker();
  late SharedPreferences prefs;

  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      _loadArgumentsFromGetArguments();
      _storeArgumentsInPreferences();
    } else {
      _loadArgumentsFromPreferences();
    }
  }

  void setInitialImages(String? frontImageUrl, String? backImageUrl) {
    if (frontImageUrl != null) {
      idFrontImageUrl.value = frontImageUrl;
    }
    if (backImageUrl != null) {
      idBackImageUrl.value = backImageUrl;
    }
  }

  void showImagePicker(BuildContext context, bool isFront) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(
                      Icons.photo_library,
                      color: TColors.primary,
                    ),
                    title: Text(
                      'اختر من الاستديو',
                      style: TextStyle(
                        color: TColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 9.sp,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    onTap: () {
                      pickImage(isFront, ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(
                    Icons.photo_camera,
                    color: TColors.primary,
                  ),
                  title: Text(
                    'التقط صورة',
                    style: TextStyle(
                      color: TColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 9.sp,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  onTap: () {
                    pickImage(isFront, ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void pickImage(bool isFront, ImageSource source) async {
    if (isFront) {
      isFrontLoading.value = true;
      frontUploadProgress.value = 0.0;
    } else {
      isBackLoading.value = true;
      backUploadProgress.value = 0.0;
    }

    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final compressedFile = await compressImage(File(pickedFile.path), isFront);
      if (isFront) {
        idFrontImage.value = compressedFile;
        idFrontImageUrl.value = '';
      } else {
        idBackImage.value = compressedFile;
        idBackImageUrl.value = '';
      }
      await _storeArgumentsInPreferences();
    }

    if (isFront) {
      isFrontLoading.value = false;
    } else {
      isBackLoading.value = false;
    }
  }

  Future<File> compressImage(File imageFile, bool isFront) async {
    final image = img.decodeImage(imageFile.readAsBytesSync())!;
    final resizedImage = img.copyResize(image, width: 800);
    final compressedImage = File(imageFile.path);

    // Simulate the compression process and update progress
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(Duration(milliseconds: 50));
      if (isFront) {
        frontUploadProgress.value = i / 100;
      } else {
        backUploadProgress.value = i / 100;
      }
    }

    compressedImage.writeAsBytesSync(img.encodeJpg(resizedImage, quality: 85));
    return compressedImage;
  }

  void uploadIDImages() async {
    if ((idFrontImage.value.path.isEmpty && idFrontImageUrl.value.isEmpty) ||
        (idBackImage.value.path.isEmpty && idBackImageUrl.value.isEmpty)) {
      Get.snackbar(
        'خطأ',
        'يرجى إضافة الصور الأمامية والخلفية',
        backgroundColor: TColors.error,
        colorText: TColors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        icon: Icon(Icons.error_outline, color: TColors.white),
        duration: Duration(seconds: 5),
      );
      return;
    }

    isLoading.value = true;
    var userId = await SharedPreferencesHelper.getInt('user_id');

    var frontImage =
    idFrontImage.value.path.isNotEmpty ? idFrontImage.value : null;
    var backImage =
    idBackImage.value.path.isNotEmpty ? idBackImage.value : null;

    var response;
    if (frontImage != null && backImage != null) {
      response = await crud.postFileAndTwoData(
        IDUploadEndpoint,
        {
          'user_id': userId.toString(),
        },
        {},
        frontImage,
        backImage,
      );
    } else {
      response = await crud.postData(
        IDUploadEndpoint,
        {
          'user_id': userId.toString(),
        },
        {},
      );
    }

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
        IDUploadResponseModel responseModel =
        IDUploadResponseModel.fromJson(data);
        if (responseModel.status) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isIdUpload', true);

          FirebaseMessaging.instance.subscribeToTopic("merchant");
          FirebaseMessaging.instance
              .subscribeToTopic("merchant${userId.toString()}");
          Get.offAll(NavigationMenu());
        } else {
          Get.snackbar(
            'خطأ',
            responseModel.error ?? 'خطأ غير معروف',
            backgroundColor: TColors.error,
            colorText: TColors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            icon: Icon(Icons.error_outline, color: TColors.white),
            duration: Duration(seconds: 5),
          );
        }
      },
    );
  }

  Future<void> _storeArgumentsInPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (idFrontImage.value.path.isNotEmpty) {
      final bytes = idFrontImage.value.readAsBytesSync();
      final base64Image = base64Encode(bytes);
      await prefs.setString('id_front_image_base64', base64Image);
    }
    if (idBackImage.value.path.isNotEmpty) {
      final bytes = idBackImage.value.readAsBytesSync();
      final base64Image = base64Encode(bytes);
      await prefs.setString('id_back_image_base64', base64Image);
    }
    await prefs.setString('id_front_image_url', idFrontImageUrl.value);
    await prefs.setString('id_back_image_url', idBackImageUrl.value);
  }

  Future<void> _loadArgumentsFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final frontImageBase64 = prefs.getString('id_front_image_base64');
    final backImageBase64 = prefs.getString('id_back_image_base64');

    if (frontImageBase64 != null && frontImageBase64.isNotEmpty) {
      final bytes = base64Decode(frontImageBase64);
      final file = File('${Directory.systemTemp.path}/id_front_image.jpg');
      await file.writeAsBytes(bytes);
      idFrontImage.value = file;
    }
    if (backImageBase64 != null && backImageBase64.isNotEmpty) {
      final bytes = base64Decode(backImageBase64);
      final file = File('${Directory.systemTemp.path}/id_back_image.jpg');
      await file.writeAsBytes(bytes);
      idBackImage.value = file;
    }
    idFrontImageUrl.value = prefs.getString('id_front_image_url') ?? '';
    idBackImageUrl.value = prefs.getString('id_back_image_url') ?? '';
  }

  void _loadArgumentsFromGetArguments() {
    idFrontImageUrl.value = Get.arguments['id_front_image'] ?? '';
    idBackImageUrl.value = Get.arguments['id_back_image'] ?? '';
  }
}
