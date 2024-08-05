import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../../core/global_resources/functions.dart';
import '../../../core/router.dart';

class Dialogs {

  static void errorAwesomeDialog (context,String desc){
    AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.topSlide,
        title: "Error",
        desc: desc,
        btnCancelOnPress: () {},
        btnOk: ElevatedButton(
          onPressed: (){},
          child: const Text("Retry"),
        )
    ).show();
  }

  static void successAwesomeDialog(context){
    AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.topSlide,
        title: "success",
        desc: "done ",
        btnOkOnPress: (){}).show();
  }

  static void loadingAwesomeDialog(context){
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog
      builder: (BuildContext context) {
        return Functions.loadingLottie();
      },
    );
  }
  static void showResultDialog(int count,context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Books Detected',
      desc: 'We found $count similar books.',
      btnOkOnPress: () {
        Navigator.of(context).pushNamed(Routers.similarBook);
      },
    ).show();
  }

  static void showNoResultDialog(context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      title: 'No Books Detected',
      desc: 'We couldn\'t find any similar books. Would you like to chat with our support?',
      btnOkText: 'Yes',
      btnOkOnPress: () {
        Navigator.of(context).pushNamed(Routers.geminiChat);
      },
      btnCancelOnPress: () {},
    ).show();
  }

  static void showErrorDialog(String message,context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Error',
      desc: message,
      btnOkOnPress: () {},
    ).show();
  }

}