import 'package:get/get.dart';
import 'package:khazana_task/app/routes/app_pages.dart';
import 'package:khazana_task/app/services/get_storage.dart';

class OnboardingController extends GetxController {
  void navigate() => Get.toNamed(Routes.AUTHENTICATION);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    StorageService storageService = Get.find<StorageService>();
    print(storageService.getFunds());
    bool isAuth = bool.tryParse(storageService.isAuthenticated()) ?? false;
    if (isAuth) {
      Get.offAllNamed(Routes.NAVIGATION);
    }
  }
}
