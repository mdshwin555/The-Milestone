import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutSectionLogo extends StatefulWidget {
  const AboutSectionLogo({Key? key}) : super(key: key);

  @override
  _AboutSectionLogoState createState() => _AboutSectionLogoState();
}

class _AboutSectionLogoState extends State<AboutSectionLogo> {
  String _version = '';
  String _osType = '';

  @override
  void initState() {
    super.initState();
    _getAppInfo();
  }

  Future<void> _getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String osType = GetPlatform.isAndroid ? 'Android' : 'iOS';

    setState(() {
      _version = version;
      _osType = osType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSizedBox.itemSpacingVertical(height: 0.5.h),
        Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: 20.h,
            width: 20.h,
          ),
        ),
        Transform.translate(
          offset: Offset(0,-1.h),
          child: Text(
            'Kwickly for $_osType v$_version',
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.grey,
              fontFamily: 'Cairo',
            ),
          ),
        ),
      ],
    );
  }
}
