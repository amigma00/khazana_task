import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:khazana_task/app/components/khazana_button.dart';
import 'package:khazana_task/app/components/khazana_textfield.dart';
import 'package:khazana_task/app/components/text_extension.dart';
import 'package:khazana_task/app/constants/app_colors.dart';
import 'package:khazana_task/app/constants/app_images.dart';
import 'package:khazana_task/app/constants/json_data.dart';
import 'package:khazana_task/app/models/stock_model.dart';
import 'package:khazana_task/app/routes/app_pages.dart';

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
        GestureDetector(
          onLongPress: () => editwatchlistBS(),
          child: TabBar(
              controller: controller.tabController,
              tabAlignment: TabAlignment.start,
              dividerHeight: 0,
              isScrollable: true,
              indicatorWeight: 0,
              indicator: BoxDecoration(),
              labelPadding: EdgeInsets.only(right: 16),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: List.generate(
                controller.watchlists.length,
                (index) {
                  return Obx(
                    () => Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: controller.currentTab.value == index
                            ? AppColors.primaryColor
                            : null,
                        border: controller.currentTab.value == index
                            ? null
                            : Border.all(color: AppColors.labelGrey2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 25,
                      child: controller.watchlists.entries
                          .toList()[index]
                          .key
                          .toString()
                          .textGilroy400(10)
                          .paddingSymmetric(horizontal: 20),
                    ),
                  );
                },
              )).paddingSymmetric(horizontal: 24),
        ),
        Gap(20),
        Expanded(
          child: Obx(
            () => TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller.tabController,
                children: controller.watchlists.keys
                    .map((e) => stockList(e))
                    .toList()),
          ),
        ),
      ],
    );
  }

  Widget stockList(String watchlist) {
    List<Stocks> stocks = controller.watchlists[watchlist] ?? [];
    controller.isAddStock.value = false;
    return GetBuilder(builder: (WatchlistController controller) {
      if (controller.isAddStock.value) {
        return searchStock(watchlist);
      } else if (stocks.isEmpty) {
        return noStock();
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KhazanaButton(
              onPressed: () => controller.onAddToWatchlistTap(),
              color: Colors.transparent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add,
                    color: AppColors.primaryColor,
                  ),
                  Gap(8),
                  'Add'.textGilroy400(
                    14,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
            ).paddingSymmetric(horizontal: 24),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Gap(16),
                padding: EdgeInsets.symmetric(horizontal: 24),
                itemCount: stocks.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () =>
                        Get.toNamed(Routes.CHARTS, arguments: stocks[index]),
                    child: Dismissible(
                      onDismissed: (direction) {
                        controller.onRemoveFromWatchlistTap(
                            watchlist, stocks[index]);
                      },
                      direction: DismissDirection.endToStart,
                      background: SizedBox.shrink(),
                      secondaryBackground: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red,
                        ),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        child: SvgPicture.asset(AppImages.trash),
                      ),
                      key: UniqueKey(),
                      child: Card(
                        margin: EdgeInsets.zero,
                        color: AppColors.textFieldFillColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                              width: 0.5, color: AppColors.labelGrey2),
                        ),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: stocks[index]
                                            .name
                                            .toString()
                                            .textGilroy400(14)),
                                    Row(
                                      children: [
                                        'NAV'.textGilroy400(12,
                                            color: AppColors.labelGrey),
                                        Gap(4),
                                        '₹${stocks[index].nav?.toStringAsFixed(2)}'
                                            .textGilroy400(14)
                                      ],
                                    )
                                  ],
                                ),
                                Gap(8),
                                Row(
                                  children: [
                                    stocks[index]
                                        .category
                                        .toString()
                                        .textGilroy400(12,
                                            color: AppColors.labelGrey),
                                    Spacer(),
                                    '1D'.textGilroy400(12,
                                        color: AppColors.labelGrey),
                                    Gap(2),
                                    '${stocks[index].change?.day?.toStringAsFixed(2)}%'
                                        .textGilroy400(12,
                                            color: AppColors.green)
                                  ],
                                )
                              ],
                            ),
                            Gap(12),
                            Divider(thickness: .5),
                            Gap(12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    '1Y'.textGilroy400(12,
                                        color: AppColors.labelGrey),
                                    Gap(2),
                                    '${stocks[index].change?.year?.toStringAsFixed(2)}%'
                                        .textGilroy400(12,
                                            color: AppColors.green)
                                  ],
                                ),
                                Row(
                                  children: [
                                    '3Y'.textGilroy400(12,
                                        color: AppColors.labelGrey),
                                    Gap(2),
                                    '${stocks[index].change?.yearT?.toStringAsFixed(2)}%'
                                        .textGilroy400(12,
                                            color: AppColors.green)
                                  ],
                                ),
                                Row(
                                  children: [
                                    '5Y'.textGilroy400(12,
                                        color: AppColors.labelGrey),
                                    Gap(2),
                                    '${stocks[index].change?.yearF?.toStringAsFixed(2)}%'
                                        .textGilroy400(12,
                                            color: AppColors.green)
                                  ],
                                ),
                                Row(
                                  children: [
                                    'Exp. Ratio'.textGilroy400(12,
                                        color: AppColors.labelGrey),
                                    Gap(2),
                                    '${stocks[index].expenseRatio?.toStringAsFixed(2)}%'
                                        .textGilroy400(12)
                                  ],
                                ),
                              ],
                            )
                          ],
                        ).paddingAll(16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }
    });
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
            onPressed: () => controller.onAddToWatchlistTap(),
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

  editwatchlistBS() {
    return Get.bottomSheet(
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  "Edit Watchlist".textGilroy400(20),
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
              Form(
                key: controller.creatWatchlistFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: controller.watchlists.keys
                      .map((e) => Builder(builder: (context) {
                            return KhazanaTextfield(
                              onFieldSubmitted: (p0) =>
                                  controller.onEditWatchlistSubmit(p0, e),
                              suffix: InkWell(
                                onTap: () => controller.removeWatchlist(e),
                                child: SvgPicture.asset(
                                  AppImages.trash,
                                  color: AppColors.errorColor,
                                ),
                              ),
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return 'Please enter watchlist name';
                                }
                                return null;
                              },
                              controller: TextEditingController(text: e),
                            ).paddingOnly(bottom: 16);
                          }))
                      .toList(),
                ).paddingSymmetric(horizontal: 50, vertical: 20),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.bottomSheetBG,
        shape: RoundedRectangleBorder());
  }

  Widget searchStock(String watchlist) {
    List<Stocks> stocks = controller.watchlists[watchlist] ?? [];
    RxString keyword = ''.obs;
    List<Stocks> getSortedList() {
      return searchStocks
          .where(
            (p0) => p0.name?.toLowerCase().contains(keyword) ?? false,
          )
          .toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: KhazanaTextfield(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 20,
                ).paddingOnly(left: 16),
                controller: TextEditingController(),
                onChanged: (p0) => keyword.value = p0,
              ).paddingSymmetric(horizontal: 16),
            ),
            IconButton(
                onPressed: () => controller.onAddToWatchlistTap(val: false),
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ))
          ],
        ),
        Expanded(
            child: Obx(
          () => ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 24),
            separatorBuilder: (context, index) => Divider(),
            itemCount: getSortedList().length,
            itemBuilder: (context, index) {
              bool isAdded = stocks.any(
                  (element) => element.name == getSortedList()[index].name);
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    getSortedList()[index].logoUrl ?? '',
                    height: 28,
                    width: 28,
                    fit: BoxFit.cover,
                  ),
                ),
                title: getSortedList()[index].name.toString().textGilroy400(12),
                trailing: InkWell(
                    onTap: () {
                      Set<Stocks>? tempStocks =
                          controller.watchlists[watchlist]?.toSet();
                      tempStocks?.add(getSortedList()[index]);
                      controller.watchlists[watchlist] =
                          tempStocks?.toList() ?? [];
                    },
                    child: isAdded
                        ? SvgPicture.asset(
                            AppImages.bookmarkOn,
                            width: 15,
                            height: 17,
                          )
                        : SvgPicture.asset(AppImages.bookmarkOff)),
              );
            },
          ),
        )),
        Gap(100)
      ],
    );
  }
}
