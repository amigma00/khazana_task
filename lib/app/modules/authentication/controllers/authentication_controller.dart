import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:khazana_task/app/components/dialog_helper.dart';

import 'package:khazana_task/app/constants/app_colors.dart';
import 'package:khazana_task/app/routes/app_pages.dart';
import 'package:khazana_task/app/services/get_storage.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationController extends GetxController {
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  GlobalKey<FormState> formKey = GlobalKey();
  PageController pageController = PageController();
  RxString timer = ''.obs;
  Rx<TextEditingController> otpController = TextEditingController().obs;
  StopWatchTimer? stopWatchTimer;
  final supabase = Supabase.instance.client;
  RxBool isActive = false.obs;
  RxBool isOtpError = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  void onNumberProceedTap() async {
    if (formKey.currentState!.validate()) {
      await sentOtpRequest();
    }
  }

  Future<void> sentOtpRequest() async {
    try {
      DialogHelper.showLoading();
      await supabase.auth
          .signInWithOtp(phone: '+91${phoneController.value.text}');
      if (pageController.page != 1) {
        pageController.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      }
      startTimer();
      isActive.value = false;
      DialogHelper.hideDialog();
    } on Exception catch (e) {
      DialogHelper.hideDialog();
      Get.snackbar('Something went wrong', e.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          borderWidth: .5,
          borderColor: AppColors.labelGrey);
      debugPrint(e.toString());
    }
  }

  Future verifyOtp(String otp) async {
    isOtpError.value = false;

    try {
      DialogHelper.showLoading();
      final response = await supabase.auth.verifyOTP(
        phone: '+91${phoneController.value.text}',
        token: otp,
        type: OtpType.sms,
      );
      DialogHelper.hideDialog();

      if (response.session?.user != null) {
        Get.find<StorageService>().saveAuthStatus('true');
        Get.toNamed(Routes.NAVIGATION);
      } else {
        Get.snackbar('Something went wrong', '',
            backgroundColor: Colors.black,
            colorText: Colors.white,
            borderWidth: .5,
            borderColor: AppColors.labelGrey);
      }
    } on Exception catch (e) {
      DialogHelper.hideDialog();
      isOtpError.value = true;
      Get.snackbar('Something went wrong', e.toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          borderWidth: .5,
          borderColor: AppColors.labelGrey);
      debugPrint(e.toString());
    }
  }

  void onEditNumberTap() => pageController.previousPage(
      duration: Duration(milliseconds: 300), curve: Curves.easeIn);

  void startTimer() {
    stopWatchTimer?.dispose();
    stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      onChangeRawSecond: (p0) {
        timer.value = StopWatchTimer.getDisplayTime(p0 * 1000,
            hours: false, minute: false, milliSecond: false);

      },
      onEnded: () => timer.value = '',
      presetMillisecond: 30 * 1000, // millisecond => minute.
    );
    stopWatchTimer?.onStartTimer();
  }

  void onResendTap() async {
    isOtpError.value = false;
    otpController.value.clear();
    await sentOtpRequest();
  }

  void onOtpProceedTap() async {
    await verifyOtp(otpController.value.text);
  }
}
