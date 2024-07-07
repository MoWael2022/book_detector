import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/core/global_resources/images_path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../core/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  _navScreen()async{
    await Future.delayed(const Duration(seconds: 7), () {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isSignIn = prefs.getBool("isSignIn") ;
    if (isSignIn == null || !isSignIn) {
      Navigator.pushReplacementNamed(context, Routers.login);
    } else {
      Navigator.pushReplacementNamed(context, Routers.home);
    }
    //Navigator.pushReplacementNamed(context, isSignIn ? Routers.homePage : Routers.login);
  }


  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _navScreen();
    super.initState();
  }

  @override
  void deactivate() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Stack(
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage(ImagePathManager.backGroundSplashScreen),
                      fit: BoxFit.cover)),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 100.w,
                height: 40.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(.8)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 27.h,
              child: SizedBox(
                width: 100.w,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(ImagePathManager.logo),
                    ),
                    Text(
                      "Book Detector",
                      style: TextStyle(
                          fontSize: 20.w,
                          color: ColorManager.white,
                          fontFamily: 'BeauRivage'),
                    ),
                    Text(
                      "Discover, capture, and explore books.",
                      style: TextStyle(
                        fontSize: 4.5.w,
                        color: ColorManager.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
