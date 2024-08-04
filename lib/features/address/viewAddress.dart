import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/address/map_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';
import '../../common/styles/custom_textstyle.dart';
import '../../common/widgets/app_bar.dart';
import '../../common/widgets/custom_sized_box.dart';
import '../../utils/constants/image_strings.dart';
import 'controller/AddressController.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:lottie/lottie.dart' as lottie;

class AddressListScreen extends StatelessWidget {
  final AddressController addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'عناويني',
        showBackArrow: true,
      ),
      body: RefreshIndicator(
        color: TColors.primary,
        onRefresh: () => addressController.fetchAddresses(),
        child: GetX<AddressController>(builder: (controller) {
          if (controller.isLoading.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  lottie.Lottie.asset(
                    TImages.loading,
                    height: 20.h,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'جاري تحميل العناوين',
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
          }

          if (controller.addresses.isEmpty) {
            return Container(
              height: 25.h,
              width: 100.w,
              color: TColors.bg,
              child: Center(
                child: SizedBox(),
              ),
            );
          }

          var defaultAddress = controller.addresses.firstWhere(
              (address) => address.isDefault == 1,
              orElse: () => controller.addresses.first);

          return Column(
            children: [
              Container(
                height: 25.h,
                width: 100.w,
                padding: EdgeInsets.all(4.w),
                child: FittedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'العنوان الافتراضي',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: TColors.primary,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          SizedBox(height: 1.5.h),
                          Text(
                            '${defaultAddress.cityName} - ${defaultAddress.addressDetails}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Cairo',
                              color: TColors.darkGrey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Container(
                        height: 15.h,
                        width: 15.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.sp),
                          child: FutureBuilder(
                            future: addressController.initialize(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else {
                                return gmaps.GoogleMap(
                                  initialCameraPosition: gmaps.CameraPosition(
                                    target: gmaps.LatLng(
                                      double.parse(defaultAddress.addressLat),
                                      double.parse(defaultAddress.addressLong),
                                    ),
                                    zoom: 11,
                                  ),
                                  markers: {
                                    gmaps.Marker(
                                      markerId:
                                          gmaps.MarkerId('default-location'),
                                      position: gmaps.LatLng(
                                        double.parse(defaultAddress.addressLat),
                                        double.parse(
                                            defaultAddress.addressLong),
                                      ),
                                      icon:
                                          addressController.merchantCustomIcon,
                                    ),
                                  },
                                  zoomControlsEnabled: false,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    width: 100.w,
                    padding: EdgeInsets.fromLTRB(3.w, 2.h, 3.w, 0),
                    decoration: BoxDecoration(
                      color: TColors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.sp)),
                    ),
                    child: controller.isLoading.value
                        ? Center(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: ListView.builder(
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      title: Container(
                                        width: 100.w,
                                        height: 20.sp,
                                        color: Colors.grey[300],
                                      ),
                                      trailing: Icon(Icons.check_circle,
                                          color: Colors.grey[300]),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : controller.addresses.isEmpty
                            ? ListView(
                                children: [
                                  SizedBox(height: 7.h),
                                  // Add some space to center the content
                                  Center(
                                    child: Image(
                                      image: AssetImage(
                                          "assets/gifs/sammy-line-sailor-on-mast-looking-through-telescope.gif"),
                                      height: 25.h,
                                    ),
                                  ),
                                  CustomSizedBox.itemSpacingVertical(
                                      height: 0.5.h),
                                  Center(
                                    child: Text(
                                      'لا توجد عناوين',
                                      style: CustomTextStyle.headlineTextStyle,
                                    ),
                                  ),
                                  CustomSizedBox.textSpacingVertical(),
                                  Center(
                                    child: Text(
                                      'أضغط على علامة + لإضافة عنوانك',
                                      style: CustomTextStyle.headlineTextStyle
                                          .apply(
                                              color: TColors.darkGrey,
                                              fontWeightDelta: -5),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                itemCount: controller.addresses.length,
                                itemBuilder: (context, index) {
                                  var address = controller.addresses[index];
                                  return Card(
                                    child: ListTile(
                                      title: Text(
                                        '${address.cityName} - ${address.addressDetails}',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                      trailing: address.isDefault == 1
                                          ? Icon(Icons.check_circle,
                                              color: TColors.primary)
                                          : null,
                                      onTap: () {
                                        addressController.setDefaultAddress(
                                            address.id.toString());
                                      },
                                    ),
                                  );
                                },
                              ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(MapScreen());
        },
        backgroundColor: TColors.primary,
        child: Icon(Icons.add, color: TColors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}