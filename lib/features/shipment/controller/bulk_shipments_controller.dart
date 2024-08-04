import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import 'package:shipment_merchent_app/core/services/storage_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shipment_merchent_app/features/shipment/model/bulk_shipment_response_model.dart';

import '../../../navigation_menu.dart';
import '../../../utils/constants/colors.dart';

class AddBulkShipmentController extends GetxController {
  var currentStep = 1.obs;
  var shipmentForms = <BulkShipmentFormModel>[].obs;
  var isExpandedList = <bool>[].obs;
  var cities = <City>[].obs;
  var isLoading = false.obs;

  List<TextEditingController> recipientNameControllers = [];
  List<TextEditingController> phoneControllers = [];
  List<TextEditingController> addressControllers = [];
  List<TextEditingController> amountControllers = [];
  List<TextEditingController> feeControllers = [];
  List<TextEditingController> notesControllers = [];
  List<RxString> selectedCityOptions = [];

  final Crud crud = Get.find<Crud>();

  double merchantLat = 31.9539; // استخدام قيم حقيقية لموقع التاجر
  double merchantLong = 35.9106;

  @override
  void onInit() {
    super.onInit();
    fetchCities();
    addShipmentForm();
  }

  void addShipmentForm() {
    shipmentForms.add(BulkShipmentFormModel());
    isExpandedList.add(false);

    recipientNameControllers.add(TextEditingController());
    phoneControllers.add(TextEditingController());
    addressControllers.add(TextEditingController());
    amountControllers.add(TextEditingController());
    feeControllers.add(TextEditingController());
    notesControllers.add(TextEditingController());
    selectedCityOptions.add(''.obs);
    shipmentForms.refresh();
    toggleExpansion(shipmentForms.length - 1);
  }

  void toggleExpansion(int index) {
    for (int i = 0; i < isExpandedList.length; i++) {
      if (i == index) {
        isExpandedList[i] = !isExpandedList[i];
      } else {
        isExpandedList[i] = false;
      }
    }
    shipmentForms.refresh();
  }

  void removeShipmentForm(int index) {
    shipmentForms.removeAt(index);
    isExpandedList.removeAt(index);
    recipientNameControllers.removeAt(index);
    phoneControllers.removeAt(index);
    addressControllers.removeAt(index);
    amountControllers.removeAt(index);
    feeControllers.removeAt(index);
    notesControllers.removeAt(index);
    selectedCityOptions.removeAt(index);
    shipmentForms.refresh();
  }

  Future<void> getsearch(String query, int index) async {
    var url = "https://photon.komoot.io/api/?q=$query&limit=5";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responsebody = jsonDecode(response.body);
      List features = responsebody['features'];

      if (features.isNotEmpty) {
        shipmentForms[index].recipientLat =
        features[0]['geometry']['coordinates'][1];
        shipmentForms[index].recipientLong =
        features[0]['geometry']['coordinates'][0];
        shipmentForms[index].recipientCity = features[0]['properties']['city'];
      }
    } else {
      throw Exception('Failed to fetch lat long');
    }
  }

  void fetchCities() async {
    isLoading.value = true;
    var response = await crud.getData(
      'https://darkred-wombat-762943.hostingersite.com/Kwickly/merchant/address/get_cities.php',
      {},
    );
    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar('Error', 'Failed to fetch cities');
      },
          (data) {
        if (data['status']) {
          cities.value =
          List<City>.from(data['data'].map((city) => City.fromJson(city)));
        } else {
          Get.snackbar('Error', 'Failed to fetch cities');
        }
      },
    );
  }

  void printShipmentData() {
    for (var form in shipmentForms) {
      print(form.toJson());
    }
  }

  Future<void> updateShippingFee(int index) async {
    double distance = await calculateDistance(
      merchantLat,
      merchantLong,
      shipmentForms[index].recipientLat,
      shipmentForms[index].recipientLong,
    );
    shipmentForms[index].shipmentDistance = distance;
    double fee = await calculateShippingFee(distance);
    shipmentForms[index].defaultShipmentFee = fee; // تحديث قيمة defaultShipmentFee
    shipmentForms[index].shipmentFee = fee.toInt(); // تعيين القيمة المحسوبة في حقل الشحن الفعلي
    feeControllers[index].text = fee.toStringAsFixed(2); // تحديث النص في حقل الإدخال
  }


  void submitShipments() async {
    var userId = await SharedPreferencesHelper.getInt('user_id');
    var payload = {
      'user_id': userId,
      'shipments': shipmentForms.map((shipment) => shipment.toJson()).toList(),
    };

    var response = await http.post(
      Uri.parse(
          'https://darkred-wombat-762943.hostingersite.com/Kwickly/merchant/shipments/add_bulk.php'),
      body: jsonEncode(payload),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      if (responseBody is List) {
        List<ResponseModel> responses =
        responseBody.map((data) => ResponseModel.fromJson(data)).toList();
        bool allSuccess = responses.every((response) => response.status);

        if (allSuccess) {
          Get.offAll(NavigationMenu());
          Get.snackbar(
            'نجاح',
            'تم إضافة الشحنات بنجاح',
            backgroundColor: TColors.primary,
            colorText: TColors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            icon: Icon(Icons.check_circle_outline, color: TColors.white),
            duration: Duration(seconds: 5),
          );
        } else {
          Get.snackbar('خطأ', 'بعض الشحنات لم يتم إضافتها');
          // طباعة الرسائل التي تحتوي على الأخطاء
          for (var response in responses) {
            if (!response.status) {
              print(response.message);
            }
          }
        }
      } else if (responseBody is Map &&
          responseBody['status'] != null &&
          !responseBody['status']) {
        Get.snackbar('خطأ', responseBody['message'] ?? 'حدث خطأ غير معروف');
        // طباعة الاستجابة لمزيد من التشخيص
        print(responseBody);
      }
    } else {
      Get.snackbar('خطأ', 'فشل الاتصال بالخادم');
      // طباعة الاستجابة لمزيد من التشخيص
      print(response.body);
    }
  }

  Future<double> calculateDistance(
      double startLat, double startLng, double endLat, double endLng) async {
    double distanceInMeters =
    Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
    double distanceInKm = distanceInMeters / 1000;
    return distanceInKm;
  }

  Future<double> calculateShippingFee(double distance) async {
    var response = await http.post(
      Uri.parse('https://darkred-wombat-762943.hostingersite.com/Kwickly/merchant/shipments/calculateShippingFeeBulk.php'),
      body: jsonEncode({'shipment_distance': distance}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        return double.parse(responseBody['shipment_fee']);
      } else {
        throw Exception('Failed to calculate shipping fee');
      }
    } else {
      throw Exception('Failed to connect to server');
    }
  }
}

class BulkShipmentFormModel {
  String recipientName = '';
  String recipientPhone = '';
  String recipientAddress = '';
  String recipientCity = '';
  double recipientLat = 0.0;
  double recipientLong = 0.0;
  String shipmentNote = '';
  String shipmentValue = '';
  int shipmentFee = 0;
  double defaultShipmentFee = 0.0; // إضافة الخاصية هنا
  double shipmentDistance = 1;

  Map<String, dynamic> toJson() {
    return {
      'recipient_name': recipientName,
      'recipient_phone': recipientPhone,
      'recipient_address': recipientAddress,
      'recipient_city': recipientCity,
      'recipient_lat': recipientLat,
      'recipient_long': recipientLong,
      'shipment_note': shipmentNote,
      'shipment_value': shipmentValue,
      'shipment_fee': shipmentFee,
      'default_shipment_fee': defaultShipmentFee, // إضافتها أيضًا هنا
      'shipment_distance': shipmentDistance,
    };
  }
}

class City {
  final int id;
  final String name;

  City({required this.id, required this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ResponseModel {
  bool status;
  String message;
  String shipmentFee; // تعديل هذا الحقل ليكون من نوع String
  String shipmentNumber;
  String shipmentId;
  Map<String, dynamic> shipmentInfo;
  Map<String, dynamic> userInfo;
  Map<String, dynamic> recipientInfo;
  dynamic deliveryInfo;
  List<dynamic> notifications;

  ResponseModel({
    required this.status,
    required this.message,
    required this.shipmentFee,
    required this.shipmentNumber,
    required this.shipmentId,
    required this.shipmentInfo,
    required this.userInfo,
    required this.recipientInfo,
    this.deliveryInfo,
    required this.notifications,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      status: json['status'],
      message: json['message'],
      shipmentFee: json['shipment_fee'].toString(), // تحويل القيمة إلى String
      shipmentNumber: json['shipment_number'] ?? '',
      shipmentId: json['shipment_id'] ?? '',
      shipmentInfo: json['shipment_info'] ?? <String, dynamic>{},
      userInfo: json['user_info'] ?? <String, dynamic>{},
      recipientInfo: json['recipient_info'] ?? <String, dynamic>{},
      deliveryInfo: json['delivery_info'],
      notifications: (json['notifications'] as List<dynamic>?) ?? [],
    );
  }
}

