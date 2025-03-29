import 'package:get/get.dart';
import 'package:khazana_task/app/routes/app_pages.dart';
import 'package:khazana_task/app/services/get_storage.dart';

class OnboardingController extends GetxController {
  void navigate() => Get.toNamed(Routes.AUTHENTICATION);

  @override
  void onReady() {
    super.onReady();

    StorageService storageService = Get.find<StorageService>();
    bool isAuth = bool.tryParse(storageService.isAuthenticated()) ?? false;
    if (isAuth) {
      Get.offAllNamed(Routes.NAVIGATION);
    }
  }
}
