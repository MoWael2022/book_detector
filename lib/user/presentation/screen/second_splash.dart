import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/core/global_resources/images_path.dart';
import 'package:khaltabita/user/presentation/controller/app_cubit.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../core/global_resources/functions.dart';
import '../../../core/router.dart';
import '../component/dialogs_component.dart';
import '../controller/app_state.dart';

class SecondSplashScreen extends StatefulWidget {
  const SecondSplashScreen({super.key});

  @override
  State<SecondSplashScreen> createState() => _SecondSplashScreenState();
}

class _SecondSplashScreenState extends State<SecondSplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _navScreen(context);
    super.initState();
  }

  _navScreen(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isSignIn = prefs.getBool("isSignIn");
    if (isSignIn == null || !isSignIn) {
      await Future.delayed(const Duration(seconds: 7));
      Navigator.pushReplacementNamed(context, Routers.login);
    } else {
      Completer<void> fetchCompleter = Completer<void>();
      Timer timer = Timer(const Duration(seconds: 15), () async {
        bool hasConnection = await Functions.hasInternetConnection();
        if (!hasConnection) {
          Dialogs.errorAwesomeDialog(context, "no Internet Connection");
        }
      });

      BlocProvider.of<AppCubit>(context).fetchData().then((_) {
        if (!fetchCompleter.isCompleted) {
          fetchCompleter.complete();
        }
      });

      BlocProvider.of<AppCubit>(context).getAllBooksFuture().then((_) {
        if (!fetchCompleter.isCompleted) {
          fetchCompleter.complete();
        }
      });

      await fetchCompleter.future;
      timer.cancel(); // Cancel the timer if the fetch completes in time

      await Future.delayed(
          const Duration(seconds: 1)); // Adding a small delay for better UX
      Navigator.pushReplacementNamed(context, Routers.home);
      // await BlocProvider.of<AppCubit>(context).fetchData();
      // await BlocProvider.of<AppCubit>(context).getAllBooksFuture();
      // await Future.delayed(const Duration(seconds: 1)); // Adding a small delay for better UX
      // Navigator.pushReplacementNamed(context, Routers.home);
    }
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
      body: BlocListener<AppCubit, AppState>(
        listener: (context, state) {
          if (state is ConnectivityLoading) {
            Dialogs.loadingAwesomeDialog(context);
          } else if (state is ConnectivityFailure) {
            Dialogs.errorAwesomeDialog(context, state.message.toString());
          } else if (state is ConnectivitySuccess) {
            Dialogs.successAwesomeDialog(context);
          }
        },
        child: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Stack(
            children: [
              Container(
                width: 100.w,
                height: 100.h,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        opacity: .7,
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
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(.8)
                      ],
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
                      ),
                      Lottie.asset(ImagePathManager.lottieBooks),
                    ],
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
