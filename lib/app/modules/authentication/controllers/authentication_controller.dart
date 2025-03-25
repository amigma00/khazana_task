import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  final count = 0.obs;

  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
  }

  void onProceedTap() {
    if (formKey.currentState!.validate()) {
      print("Proceed Tapped");
    }
  }
}
