import 'package:get/get.dart';
import 'package:khazana_task/app/modules/watchlist/controllers/watchlist_controller.dart';

import '../controllers/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(
      () => NavigationController(),
    );
    Get.lazyPut<WatchlistController>(
      () => WatchlistController(),
    );
  }
}
