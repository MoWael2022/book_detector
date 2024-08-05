import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/core/global_resources/constants.dart';
import 'package:khaltabita/core/global_resources/images_path.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../../core/global_resources/functions.dart';
import '../../../core/router.dart';

class FirstSplashScreen extends StatefulWidget {
  const FirstSplashScreen({super.key});

  @override
  State<FirstSplashScreen> createState() => _SecondSplashScreenState();
}

class _SecondSplashScreenState extends State<FirstSplashScreen>
    with SingleTickerProviderStateMixin {
  bool _isConnected = false;

  Future<void> _checkConnectivityAndNavigate() async {
    var result = await Connectivity().checkConnectivity();
    bool hasInternet = await Functions.hasInternetConnection();
    print(hasInternet);
    setState(() {
      _isConnected = result != ConnectivityResult.none && hasInternet;
    });

    if (_isConnected) {
      await Future.delayed(const Duration(seconds: 7));
      _navScreen();
    } else {
      _showNoInternetDialog();
    }
  }

  _showNoInternetDialog() {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.topSlide,
        title: "Error",
        desc: "No internet please check the Internet connection then retry",
        btnCancelOnPress: () {},
        btnOk: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            _checkConnectivityAndNavigate();
          },
          child: const Text("Retry"),
        )).show();
  }

  _navScreen() async {
    Navigator.pushReplacementNamed(context, Routers.secondSplashScreen);
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    //_navScreen();
    _checkConnectivityAndNavigate();
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
        body: Center(
      child: Lottie.asset(ImagePathManager.lottieBook),
    ));
  }
}
