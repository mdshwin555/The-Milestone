import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/utils/constants/image_strings.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/custom_drawer.dart';
import '../../../utils/constants/colors.dart';
import '../../home/controller/home_controller.dart';
import '../../home/screen/widgets/ads_widget.dart';
import '../../home/screen/widgets/app_bar.dart';
import '../../personalization/screens/widgets/EventFilterButton.dart';
import '../controller/shimpments_controller.dart';

class ShipmentScreen extends StatelessWidget {
  final ShipmentsController controller = Get.put(ShipmentsController());
  final HomeController controller1 = Get.put(HomeController());
  final RxInt _currentAdIndex = 0.obs;

  ShipmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: TColors.white,
      body: WillPopScope(
        onWillPop: () => controller1.onWillPop(context),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0.h,
                child: HomeAppBar(
                  title: '',
                ),
              ),
              Positioned(
                bottom: 0.h,
                child: Container(
                  height: 47.6.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: TColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.sp),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const AdsWidget(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                EventFilterButton(
                                  label: 'Popular',
                                  index: 0,
                                  onTap: (index) {},
                                ),
                                EventFilterButton(
                                  label: 'Offers',
                                  index: 1,
                                  onTap: (index) {},
                                ),
                                EventFilterButton(
                                  label: 'New',
                                  index: 2,
                                  onTap: (index) {},
                                ),
                                EventFilterButton(
                                  label: 'Kids',
                                  index: 3,
                                  onTap: (index) {},
                                ),
                                EventFilterButton(
                                  label: 'Adult',
                                  index: 4,
                                  onTap: (index) {},
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 70.h,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(8.0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Card(
                                color: TColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(15.0)),
                                          child: Image.asset(
                                            TImages.course1,
                                            fit: BoxFit.cover,
                                            height: 120,
                                            width: double.infinity,
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          left: 8,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.yellow,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 2),
                                            child: Text(
                                              '25%',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Preparation for IELTS',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: TColors.bg,
                                            fontSize: 10.sp),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            '24 Sessions',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              color: TColors.bg,
                                              fontSize: 9.sp,
                                            ),
                                          ),
                                          SizedBox(width: 1.w),
                                          Icon(
                                            Icons.schedule,
                                            size: 10.sp,
                                            color: TColors.bg,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(2.w, 1.h, 0, 0),
                                      child: Text(
                                        '400,000 S.P',
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                            color: TColors.bg,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
