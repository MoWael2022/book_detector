import 'dart:io';

import 'package:flutter/material.dart';
import 'package:khaltabita/core/global_resources/images_path.dart';
import 'package:lottie/lottie.dart';

class Functions {
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('facebook.com');
      print(result);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  static Widget loadingLottie ()  {
    return Center(
      child:  Lottie.asset(ImagePathManager.loadingLottie),
    );
  }
}