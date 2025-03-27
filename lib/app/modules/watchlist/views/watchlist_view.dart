import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:khazana_task/app/components/khazana_button.dart';
import 'package:khazana_task/app/components/khazana_textfield.dart';
import 'package:khazana_task/app/components/text_extension.dart';
import 'package:khazana_task/app/constants/app_colors.dart';
import 'package:khazana_task/app/constants/app_images.dart';

import '../controllers/watchlist_controller.dart';

class WatchlistView extends GetView<WatchlistController> {
  const WatchlistView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        onPressed: () => createWatchlistBS(),
        label: 'Watchlist'.textGilroy400(12),
        icon: Icon(Icons.add),
      ),
      body: Obx(() => switchCase()),
    );
  }

  Widget switchCase() => switch (controller.watchlistState.value) {
        WatchlistStatus.noWatchlist => noWatchlist(),
        WatchlistStatus.loaded => loadWatchlist(),
        WatchlistStatus.error => 'Something went wrong'.textGilroy400(12)
      };

  Widget loadWatchlist() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TabBar(
            controller: controller.tabController,
            tabAlignment: TabAlignment.start,
            dividerHeight: 0,
            isScrollable: true,
            indicator: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            labelPadding: EdgeInsets.only(right: 16),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: List.generate(
              controller.watchlists.length,
              (index) {
                return Tab(
                  height: 25,
                  child: controller.watchlists[index]
                      .toString()
                      .textGilroy400(10)
                      .paddingSymmetric(horizontal: 20),
                );
              },
            )).paddingSymmetric(horizontal: 24),
        Gap(20),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: List.generate(
              controller.watchlists.length,
              (index) {
                return ListView.builder(
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: 'Company Name'.textGilroy400(14),
                      subtitle: 'Company Symbol'.textGilroy400(12),
                      trailing: '₹ 1000'.textGilroy400(14),
                    );
                  },
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Center noStock() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppImages.noWatchlist),
          Gap(16),
          'Looks like your watchlist is empty.'
              .textGilroy400(14, color: AppColors.labelGrey2),
          Gap(32),
          KhazanaButton(
            isActive: false,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                Gap(8),
                'Add to Watchlist'.textGilroy400(14)
              ],
            ).paddingSymmetric(horizontal: 16),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget noWatchlist() {
    return Center(
        child: 'No Watchlist, Please create a watchlist'
            .textGilroy400(12, color: Colors.white));
  }

  createWatchlistBS() {
    RxBool isActive = false.obs;
    return Get.bottomSheet(
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  "Create new watchlist".textGilroy400(20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        controller.watchlistNameController.clear();
                        Get.back();
                      },
                    ),
                  ),
                ],
              ).paddingAll(16),
              Divider(
                thickness: .3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Form(
                    key: controller.creatWatchlistFormKey,
                    child: KhazanaTextfield(
                      label: 'Watchlist Name',
                      hintText: 'Enter watchlist name',
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Please enter watchlist name';
                        }
                        return null;
                      },
                      controller: controller.watchlistNameController,
                      onChanged: (p0) => p0.isEmpty
                          ? isActive.value = false
                          : isActive.value = true,
                    ),
                  ),
                  Gap(24),
                  Obx(() => KhazanaButton(
                        onPressed: () => controller.createWatchlist(),
                        text: 'Create',
                        isActive: isActive.value,
                      )),
                ],
              ).paddingSymmetric(horizontal: 50, vertical: 20),
            ],
          ),
        ),
        backgroundColor: AppColors.bottomSheetBG,
        shape: RoundedRectangleBorder());
  }
}
