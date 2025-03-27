import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:khazana_task/app/constants/app_images.dart';

class NavigationController extends GetxController {
  PageController pageController = PageController();
  final List bottomItems = [
    AppImages.home,
    AppImages.chart,
    AppImages.watchlist
  ];
  RxInt currentIndex = 0.obs;
  onIconTap(int value) {
    currentIndex.value = value;
    pageController.jumpToPage(currentIndex.value);
    print(currentIndex.value);
  }
}
