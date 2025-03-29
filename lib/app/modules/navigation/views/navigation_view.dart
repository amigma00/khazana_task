// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:khazana_task/app/components/text_extension.dart';
import 'package:khazana_task/app/constants/app_colors.dart';
import 'package:khazana_task/app/constants/app_images.dart';

import 'package:khazana_task/app/modules/home/views/home_view.dart';
import 'package:khazana_task/app/modules/watchlist/views/watchlist_view.dart';

import '../controllers/navigation_controller.dart';

class NavigationView extends GetView<NavigationController> {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            centerTitle: false,
            leading: controller.currentIndex.value == 2
                ? null
                : Center(
                    child: SvgPicture.asset(
                      AppImages.appBarLogo,
                    ),
                  ),
            title: controller.currentIndex.value != 2
                ? null
                : 'Watchlist'.textGilroy400(20),
            actions: controller.currentIndex.value == 2
                ? null
                : [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                  ],
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(),
              Obx(
                () => BottomNavigationBar(
                    currentIndex: controller.currentIndex.value,
                    onTap: (value) => controller.onIconTap(value),
                    items: List.generate(
                      controller.bottomItems.length,
                      (index) {
                        return BottomNavigationBarItem(
                          label: ['Home', 'Charts', 'Watchlist'][index],
                          icon: SvgPicture.asset(controller.bottomItems[index]),
                          activeIcon: SvgPicture.asset(
                            controller.bottomItems[index],
                            color: AppColors.primaryColor,
                          ),
                        );
                      },
                    )).paddingSymmetric(horizontal: 50),
              ),
              Divider(),
            ],
          ),
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            children: [HomeView(), Container(), WatchlistView()],
          ),
        ),
      ),
    );
  }
}
