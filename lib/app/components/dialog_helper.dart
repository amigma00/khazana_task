import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  static void showLoading() {
    Get.dialog(
      PopScope(
          canPop: false,
          child: Center(
            child: CircularProgressIndicator(),
          )),
      barrierDismissible: false,
      barrierColor: const Color(0xff141A31).withOpacity(.4),
      useSafeArea: true,
    );
  }

  //hide loading
  static void hideDialog() {
    if (Get.isDialogOpen!) Get.until((route) => !Get.isDialogOpen!);
  }
}
