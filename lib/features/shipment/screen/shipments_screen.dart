import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/features/shipment/screen/tracking_screen.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/shipments_widgets/FilterButton.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/shipments_widgets/shippments_shimmer_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../home/controller/home_controller.dart';
import '../../home/screen/qrsearch_screen.dart';
import '../../home/screen/search_screen.dart';
import '../controller/shimpments_controller.dart';

class ShipmentScreen extends StatelessWidget {
  final ShipmentsController controller = Get.put(ShipmentsController());
  final HomeController controller1 = Get.put(HomeController());

  ShipmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'الشحنات',
      ),
      body: WillPopScope(
        onWillPop: () => controller1.onWillPop(context),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: FutureBuilder<void>(
            future: controller.fetchShipments(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        TImages.loading,
                        height: 20.h,
                      ),
                      SizedBox(height: 2.h),
                      // Add some spacing between the animation and the text
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
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        TImages.loading,
                        height: 20.h,
                      ),
                      SizedBox(height: 2.h),
                      // Add some spacing between the animation and the text
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
                    await controller.fetchShipments();
                  },
                  color: TColors.primary,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Row(
                            children: [
                              TSearchContainer(
                                text: "ابحث عن الشحنة",
                                onTap: () {
                                  Get.to(SearchScreen());
                                },
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              CircularContainer(
                                onTap: () {
                                  Get.to(BarcodeSearchScreen());
                                },
                                icon: Icons.qr_code_scanner,
                                color: TColors.primary,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                CustomFilterButton(
                                  icon: Iconsax.box,
                                  label: 'بانتظار قبولها',
                                  index: 0,
                                  selectedFilterIndex: controller.selectedFilterIndex,
                                  onTap: (index) {
                                    controller.setSelectedFilterIndex(index);
                                    controller.fetchShipments();
                                  },
                                ),
                                CustomFilterButton(
                                  icon: Iconsax.box_time4,
                                  label: 'قيد التوصيل',
                                  index: 1,
                                  selectedFilterIndex: controller.selectedFilterIndex,
                                  onTap: (index) {
                                    controller.setSelectedFilterIndex(index);
                                    controller.fetchShipments();
                                  },
                                ),
                                CustomFilterButton(
                                  icon: Iconsax.box_tick,
                                  label: 'المكتملة',
                                  index: 2,
                                  selectedFilterIndex: controller.selectedFilterIndex,
                                  onTap: (index) {
                                    controller.setSelectedFilterIndex(index);
                                    controller.fetchShipments();
                                  },
                                ),
                                CustomFilterButton(
                                  icon: Iconsax.box_tick,
                                  label: 'الملغية',
                                  index: 3,
                                  selectedFilterIndex: controller.selectedFilterIndex,
                                  onTap: (index) {
                                    controller.setSelectedFilterIndex(index);
                                    controller.fetchShipments();
                                  },
                                ),
                                CustomFilterButton(
                                  icon: Iconsax.box_remove,
                                  label: 'الراجعة',
                                  index: 4,
                                  selectedFilterIndex: controller.selectedFilterIndex,
                                  onTap: (index) {
                                    controller.setSelectedFilterIndex(index);
                                    controller.fetchShipments();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Obx(() {
                          if (controller.isLoading.value) {
                            return ShippmentShimmerWidget(); // Use the Shimmer Widget when loading
                          }
                          return Container(
                            height: 47.6.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: TColors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.sp),
                              ),
                            ),
                            child: controller.filteredShipments.isEmpty
                                ? Center(
                              child: ListView(
                                padding: EdgeInsets.all(5.w),
                                children: [
                                  SizedBox(height: 3.h),
                                  Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: AssetImage("assets/gifs/sammy-line-sailor-on-mast-looking-through-telescope.gif"),
                                          height: 25.h,
                                        ),
                                        CustomSizedBox.itemSpacingVertical(height: 0.4.h),
                                        Text(
                                          'لا توجد شحنات',
                                          style: CustomTextStyle.headlineTextStyle,
                                        ),
                                        CustomSizedBox.textSpacingVertical(),
                                        Text(
                                          'حاول لاحقًا لمعرفة ما إذا كان هناك جديد',
                                          style: CustomTextStyle.headlineTextStyle.apply(color: TColors.darkGrey, fontWeightDelta: -5),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : ListView.builder(
                              padding: EdgeInsets.all(5.w),
                              itemCount: controller.filteredShipments.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final shipment = controller.filteredShipments[index];
                                return Padding(
                                  padding: EdgeInsets.only(top: 6.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(TrackingScreen(shipmentId: shipment.shipmentId));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(right: 5.w),
                                      height: 22.h,
                                      width: 80.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.sp),
                                        color: TColors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: TColors.black.withOpacity(0.25),
                                            blurRadius: 8,
                                            spreadRadius: 5,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 17.h,
                                            width: 17.h,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15.sp),
                                              image: DecorationImage(
                                                image: AssetImage("assets/images/fast.png"),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 2.h, right: 6.w),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    shipment.shipmentContents,
                                                    style: CustomTextStyle.headlineTextStyle.apply(fontSizeFactor: 0.7, fontWeightDelta: 2),
                                                  ),
                                                ),
                                                CustomSizedBox.textSpacingVertical(),
                                                Text(
                                                  '#${shipment.shipmentNumber}',
                                                  style: CustomTextStyle.greyTextStyle,
                                                ),
                                                CustomSizedBox.textSpacingVertical(),
                                                Row(
                                                  children: [
                                                    Image(
                                                      image: AssetImage('assets/images/Subtract (1).png'),
                                                      height: 5.h,
                                                      width: 5.w,
                                                    ),
                                                    SizedBox(width: 2.w),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          shipment.senderCity+'-'+shipment.senderFromAddressDetails,
                                                          style: CustomTextStyle.headlineTextStyle.apply(fontSizeFactor: 0.6),
                                                        ),
                                                        Text(
                                                          shipment.createdAt.split(' ')[0],
                                                          style: CustomTextStyle.greyTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(right: 2.w),
                                                  child: Image(
                                                    image: AssetImage("assets/images/Line 15.png"),
                                                    height: 2.h,
                                                    width: 1.2.w,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Image(
                                                      image: AssetImage('assets/images/Subtract (2).png'),
                                                      height: 5.h,
                                                      width: 5.w,
                                                    ),
                                                    SizedBox(width: 2.w),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          shipment.recipientCity == null ? 'جاري التحميل ...' : shipment.recipientCity!+'-'+shipment.recipientAddress,
                                                          style: CustomTextStyle.headlineTextStyle.apply(fontSizeFactor: 0.6),
                                                        ),
                                                        Text(
                                                          shipment.estimatedDeliveryTime.split(' ')[0],
                                                          style: CustomTextStyle.greyTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
