import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shipment_merchent_app/core/integration/crud.dart';
import 'package:shipment_merchent_app/core/services/storage_service.dart';
import 'package:shipment_merchent_app/features/shipment/controller/shimpments_controller.dart';
import 'package:shipment_merchent_app/navigation_menu.dart';
import 'package:shipment_merchent_app/utils/constants/api_constants.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'dart:async';

import 'package:sizer/sizer.dart';

class TrackingController extends GetxController {
  final int shipmentId;
  TrackingController({required this.shipmentId});

  var isLoading = true.obs;
  var isSuccess = false.obs;
  var shipmentInfo = {}.obs;
  var recipientInfo = {}.obs;
  var deliveryInfo = {}.obs;
  var merchantInfo = {}.obs;
  var announcements = [].obs;
  var polylineCoordinates = <LatLng>[].obs;

  late BitmapDescriptor merchentCustomIcon;
  late BitmapDescriptor deliveryCustomIcon;
  late BitmapDescriptor recipentCustomIcon;
  final Completer<GoogleMapController> _controllerCompleter = Completer<GoogleMapController>();
  final ShipmentsController shipmentsController = Get.put(ShipmentsController());

  final Crud crud = Get.find<Crud>();

  String mapKey = 'AIzaSyBJjDpq0S-cRzOkfeC2NtIvch3sVxXmWjs';

  @override
  Future<void> onInit() async {
    super.onInit();
    await setCustomMarkerIcons();
    await fetchShipmentDetails();
  }

  Future<void> fetchShipmentDetails() async {
    isLoading.value = true;
    var userId = await SharedPreferencesHelper.getInt('user_id');
    final response = await http.post(
      Uri.parse(ViewShipmentByIdEndpoint),
      body: {
        'user_id': userId.toString(),
        'shipment_id': shipmentId.toString()
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status']) {
        shipmentInfo.value = data['shipment_info'];
        recipientInfo.value = data['recipient_info'];
        merchantInfo.value = data['user_info'];
        announcements.value = data['announcements'];
        deliveryInfo.value = data['delivery_user_info'];
        await getRoute();
        isSuccess.value = true;
      } else {
        isSuccess.value = false;
        print(response.statusCode);
      }
    } else {
      isSuccess.value = false;
      print(response.statusCode);
    }

    isLoading.value = false;
  }

  Future<void> rateDelivery(double rating, String comment) async {
    var userId = await SharedPreferencesHelper.getInt('user_id');
    var deliveryUserId = deliveryInfo['id'];  // Assuming delivery user id is stored here
    print('///////////////////////////');
    print(userId);
    print(shipmentId.toString());
    print(deliveryUserId.toString());
    print(rating.toString());
    print(comment);

    final response = await crud.postData(
        'https://darkred-wombat-762943.hostingersite.com/Kwickly/merchant/shipments/rate_delivery.php',
        {
          'shipment_id': shipmentId.toString(),
          'rater_id': userId.toString(),
          'ratee_id': deliveryUserId.toString(),
          'rating': rating.toString(),
          'comment': comment,
        },
        {}
    );

    response.fold(
          (failure) {
        Get.snackbar(
          'خطأ',
          'فشل تقييم المندوب',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          icon: Icon(Icons.error_outline, color: Colors.white),
        );
      },
          (data) {
        if (data['status']) {
          Get.snackbar(
            'نجاح',
            'تم تقييم المندوب بنجاح',
            backgroundColor: TColors.primary,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            icon: Icon(Icons.check_circle_outline, color: Colors.white),
            duration: Duration(seconds: 5),
          );
        } else {
          Get.snackbar(
            'خطأ',
            data['message'] ?? 'فشل تقييم المندوب',
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            icon: Icon(Icons.error_outline, color: Colors.white),
          );
        }
      },
    );
  }


  Future<void> cancelShipment() async {
    var userId = await SharedPreferencesHelper.getInt('user_id');
    final response = await http.post(
      Uri.parse(CancelShipmenEndpoint),
      body: {
        'user_id': userId.toString(),
        'shipment_id': shipmentId.toString()
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status']) {
        shipmentsController.fetchShipments();
        Get.to(NavigationMenu());

        Get.snackbar(
          'نجاح',
          'تم حذف شحنتك بنجاح',
          backgroundColor: TColors.primary,
          colorText: TColors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          icon: Icon(Icons.error_outline, color: TColors.white),
          titleText: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              'نجاح',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: TColors.white,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          messageText: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              'تم حذف شحنتك بنجاح',
              style: TextStyle(
                fontSize: 10.sp,
                color: TColors.white,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        );

      } else {
        print('Failed to cancel shipment');
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  }


  Future<void> getRoute() async {
    final origin = '${merchantInfo['from_address_lat']},${merchantInfo['from_address_long']}';
    final destination = '${recipientInfo['lat']},${recipientInfo['long']}';
    final response = await http.get(
      Uri.parse('https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$mapKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final polylinePoints = data['routes'][0]['overview_polyline']['points'];
        polylineCoordinates.value = _decodePolyline(polylinePoints);
        _fitCameraToPolylineBounds();
      }
    }
  }

  List<LatLng> _decodePolyline(String polyline) {
    var points = <LatLng>[];
    var index = 0;
    var len = polyline.length;
    var lat = 0;
    var lng = 0;

    while (index < len) {
      var b = 0;
      var shift = 0;
      var result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      var dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      var dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }

  void _fitCameraToPolylineBounds() async {
    if (polylineCoordinates.isEmpty) return;

    LatLngBounds bounds = _calculateLatLngBounds(polylineCoordinates);
    final GoogleMapController controller = await _controllerCompleter.future;
    controller.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50.0),
    );
  }

  LatLngBounds _calculateLatLngBounds(List<LatLng> points) {
    double x0 = points[0].latitude;
    double x1 = points[0].latitude;
    double y0 = points[0].longitude;
    double y1 = points[0].longitude;

    for (LatLng point in points) {
      if (point.latitude > x1) x1 = point.latitude;
      if (point.latitude < x0) x0 = point.latitude;
      if (point.longitude > y1) y1 = point.longitude;
      if (point.longitude < y0) y0 = point.longitude;
    }
    return LatLngBounds(
      northeast: LatLng(x1, y1),
      southwest: LatLng(x0, y0),
    );
  }

  Future<void> setCustomMarkerIcons() async {
    merchentCustomIcon = await createCustomMarkerIcon('assets/images/merchant_mark.png');
    recipentCustomIcon = await createCustomMarkerIcon('assets/images/recipent_mark.png');
  }

  Future<BitmapDescriptor> createCustomMarkerIcon(String assetPath) async {
    final ByteData byteData = await rootBundle.load(assetPath);
    final Uint8List imageData = byteData.buffer.asUint8List();

    final ui.Codec codec = await ui.instantiateImageCodec(imageData, targetWidth: 70, targetHeight: 100);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? resizedImageData = await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List resizedImageBytes = resizedImageData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(resizedImageBytes);
  }

  void onMapCreated(GoogleMapController controller) {
    _controllerCompleter.complete(controller);
    if (polylineCoordinates.isNotEmpty) {
      _fitCameraToPolylineBounds();
    }
  }
}
