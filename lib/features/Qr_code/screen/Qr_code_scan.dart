import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/Qr_code/screen/widgets/qr_view_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import '../../../common/widgets/colored_app_bar.dart';
import '../../home/controller/home_controller.dart';
import '../controller/barcode_scan_controller.dart';

class BarcodeScanScreen extends StatelessWidget {
  const BarcodeScanScreen({Key? key, required this.onBarcodeScanned})
      : super(key: key);
  final void Function(String barcode) onBarcodeScanned;

  @override
  Widget build(BuildContext context) {
    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
    QRViewController? controller;
    final BarcodeScanController barcodeController =
        Get.put(BarcodeScanController());
    final homecontroller = Get.find<HomeController>();

    void _onQRViewCreated(QRViewController qrController) {
      controller = qrController;
      qrController.scannedDataStream.listen((scanData) {
        final barcode = scanData.code ?? "";
        barcodeController.updateBarcode(barcode);
        qrController.pauseCamera();
        onBarcodeScanned(barcode); // استدعاء الدالة عند مسح الباركود
      });
    }

    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: const TCAppBar(
        title: 'Qr Scanner',
        showBackArrow: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  controller?.resumeCamera();
                },
                child: Center(
                  child: Container(
                    height: 25.h,
                    width: 60.w,
                    decoration: const BoxDecoration(),
                    child: Center(
                      child: QrViewWidget(
                        qrKey: qrKey,
                        onQRViewCreated: _onQRViewCreated,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 13.h),
              Container(
                width: double.infinity,
                height: 7.h,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: ElevatedButton(
                  onPressed: () async {
                    await homecontroller.receiveShipmentBack(
                        homecontroller.shippmentController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Obx(
                    () {
                      return Text(
                        homecontroller.isLoading.value ? 'SCAN ME' : 'SCAN ME',
                        style: CustomTextStyle.headlineTextStyle
                            .apply(color: TColors.white),
                      );
                    },
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
