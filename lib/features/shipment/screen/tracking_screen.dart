import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:lottie/lottie.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/tracking_widgets/announcements_tab.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/tracking_widgets/electronic_receipt_tab.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/tracking_widgets/shipment_events_tab.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/tracking_widgets/sliver_app_bar_delegate.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import '../../../navigation_menu.dart';
import '../../../utils/constants/image_strings.dart';
import '../controller/shimpments_controller.dart';
import '../controller/tracking_controller.dart';

class TrackingScreen extends StatelessWidget {
  final int shipmentId;

  const TrackingScreen({required this.shipmentId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TrackingController controller = Get.put(TrackingController(shipmentId: shipmentId), tag: shipmentId.toString());
    final ShipmentsController shipmentsController = Get.put(ShipmentsController());

    return DefaultTabController(
      initialIndex: 2,
      length: 3,
      child: Scaffold(
        appBar: TAppBar(
          title: 'متابعة الشحنة',
          showBackArrow: true,
          leadingOnPressed: () {
            shipmentsController.fetchShipments();
            Get.offAll(NavigationMenu());
          },
        ),
        backgroundColor: TColors.white,
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    TImages.loading,
                    height: 20.h,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'جاري تحميل الشحنة',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: TColors.darkGrey,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          } else if (!controller.isSuccess.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    TImages.loading,
                    height: 20.h,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'جاري تحميل الشحنات',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: TColors.darkGrey,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                await controller.fetchShipmentDetails();
              },
              color: TColors.primary,
              child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: 50.h,
                      floating: true,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Container(
                              height: 50.h,
                              child: Obx(() {
                                if (controller.polylineCoordinates.isEmpty) {
                                  return Center(child: CircularProgressIndicator(color: TColors.primary));
                                }
                                final recipientInfo = controller.recipientInfo.value;
                                final merchantInfo = controller.merchantInfo.value;
                                return maps.GoogleMap(
                                  zoomGesturesEnabled: true,
                                  scrollGesturesEnabled: true,
                                  tiltGesturesEnabled: true,
                                  rotateGesturesEnabled: true,
                                  onMapCreated: controller.onMapCreated,
                                  zoomControlsEnabled: false,
                                  initialCameraPosition: maps.CameraPosition(
                                    target: maps.LatLng(
                                      double.parse(recipientInfo['lat'] ?? '0.0'),
                                      double.parse(recipientInfo['long'] ?? '0.0'),
                                    ),
                                    zoom: 14,
                                  ),
                                  markers: {
                                    maps.Marker(
                                      markerId: maps.MarkerId('shipment-location'),
                                      position: maps.LatLng(
                                        double.parse(recipientInfo['lat'] ?? '0.0'),
                                        double.parse(recipientInfo['long'] ?? '0.0'),
                                      ),
                                      icon: controller.recipentCustomIcon,
                                      infoWindow: maps.InfoWindow(title: 'Shipment Location'),
                                    ),
                                    maps.Marker(
                                      markerId: maps.MarkerId('shipment-location2'),
                                      position: maps.LatLng(
                                        double.parse(merchantInfo['from_address_lat'] ?? '0.0'),
                                        double.parse(merchantInfo['from_address_long'] ?? '0.0'),
                                      ),
                                      icon: controller.merchentCustomIcon,
                                      infoWindow: maps.InfoWindow(title: 'Merchant Location'),
                                    ),
                                  },
                                  polylines: {
                                    maps.Polyline(
                                      polylineId: maps.PolylineId('route'),
                                      points: controller.polylineCoordinates,
                                      color: TColors.primary,
                                      width: 5,
                                    ),
                                  },
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      delegate: SliverAppBarDelegate(
                        TabBar(
                          labelColor: TColors.primary,
                          unselectedLabelColor: TColors.grey,
                          indicatorColor: TColors.primary,
                          tabs: [
                            Tab(
                              child: Text(
                                'التبليغات',
                                style: TextStyle(fontFamily: 'Cairo'),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'الإيصال الإلكتروني',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: 'Cairo', fontSize: 10.sp),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'أحداث الشحنة',
                                style: TextStyle(fontFamily: 'Cairo'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      pinned: true,
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    RefreshIndicator(
                      onRefresh: () async {
                        await controller.fetchShipmentDetails();
                      },
                      color: TColors.primary,
                      child: AnnouncementsTab(controller),
                    ),
                    RefreshIndicator(
                      onRefresh: () async {
                        await controller.fetchShipmentDetails();
                      },
                      color: TColors.primary,
                      child: ElectronicReceiptTab(controller),
                    ),
                    RefreshIndicator(
                      onRefresh: () async {
                        await controller.fetchShipmentDetails();
                      },
                      color: TColors.primary,
                      child: ShipmentEventsTab(controller),
                    ),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}

