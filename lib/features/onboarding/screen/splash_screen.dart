import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../navigation_menu.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../auth/screen/id_upload_screen.dart';
import '../../auth/screen/personal_info_screen.dart';
import '../controller/onboarding_controller.dart';
import 'onboarding_screen.dart';
import 'package:shipment_merchent_app/features/auth/screen/login_screen.dart';

class MyCustomSplashScreen extends StatefulWidget {
  @override
  _MyCustomSplashScreenState createState() => _MyCustomSplashScreenState();
}

class _MyCustomSplashScreenState extends State<MyCustomSplashScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late AnimationController controller;
  late Animation<double> animation1;
  late OnBoardingController onBoardingController;

  @override
  void initState() {
    super.initState();

    onBoardingController = Get.put(OnBoardingController());

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    controller.forward();

    Timer(Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(Duration(seconds: 4), () {
      setState(() {
        bool isIdUpload =
            onBoardingController.prefs.getBool('isIdUpload') ?? false;
        bool isPersonalInfo =
            onBoardingController.prefs.getBool('isPersonalInfo') ?? false;
        bool isAuth = onBoardingController.prefs.getBool('isAuth') ?? false;
        bool isFirstTime =
            onBoardingController.prefs.getBool('isFirstTime') ?? true;

        Navigator.pushReplacement(
          context,
          PageTransition(
            isIdUpload == true
                ? NavigationMenu()
                : isPersonalInfo == true
                    ? IDUploadScreen()
                    : isAuth == true
                        ? PersonalInfoScreen()
                        : isFirstTime == true
                            ? OnBoardingScreen()
                            : LoginScreen(),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      //backgroundColor: TColors.primary,
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              TColors.white,
              TColors.primary,
            ])),
        child: Stack(
          children: [
            Column(
              children: [
                AnimatedContainer(
                    duration: Duration(milliseconds: 2000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: _height / _fontSize),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 1000),
                  opacity: _textOpacity,
                  child: Text(
                    'KWICKLY APP',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: animation1.value,
                        fontFamily: 'Cairo'),
                  ),
                ),
              ],
            ),
            Center(
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                opacity: _containerOpacity,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _width / _containerSize,
                  width: _width / _containerSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: AssetImage(TImages.app_icon),
                      )),
                  // child: Image.asset('assets/images/file_name.png')
                  child: Text(
                    '',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}
