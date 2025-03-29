import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:khazana_task/app/components/dialog_helper.dart';
import 'package:khazana_task/app/components/khazana_button.dart';
import 'package:khazana_task/app/components/khazana_snackbar.dart';
import 'package:khazana_task/app/constants/app_colors.dart';
import 'package:khazana_task/app/constants/app_images.dart';
import 'package:khazana_task/app/models/stock_model.dart';
import 'package:khazana_task/app/services/get_storage.dart';

class WatchlistController extends GetxController
    with GetTickerProviderStateMixin {
  RxMap<String, List<Stocks>> watchlists = <String, List<Stocks>>{}.obs;
  final watchlistState = WatchlistStatus.noWatchlist.obs;
  TextEditingController watchlistNameController = TextEditingController();
  GlobalKey<FormState> creatWatchlistFormKey = GlobalKey<FormState>();
  late TabController tabController;
  RxBool isAddStock = false.obs;
  StorageService storageService = Get.find<StorageService>();
  RxInt currentTab = 0.obs;
  @override
  void onInit() {
    super.onInit();
    watchlistMapListener();

    watchlists.value = storageService.getFunds().map(
          (key, value) => MapEntry(
              key,
              (value as List)
                  .map(
                    (e) => Stocks.fromJson(e),
                  )
                  .toList()),
        );
    tabController = TabController(
      length: watchlists.length,
      vsync: this,
    );
    tabController.addListener(
      () {
        currentTab.value = tabController.index;
      },
    );
  }

  createWatchlist() {
    if (creatWatchlistFormKey.currentState!.validate()) {
      watchlists[watchlistNameController.text] = [];
      watchlistNameController.clear();
      tabController.dispose();
      tabController = TabController(
        length: watchlists.length,
        vsync: this,
      );
      tabController.addListener(
        () {
          currentTab.value = tabController.index;
        },
      );
      Get.back();
    }
  }

  void watchlistMapListener() {
    watchlists.listen(
      (p0) {
        if (p0.isEmpty) {
          watchlistState.value = WatchlistStatus.noWatchlist;
        } else {
          watchlistState.value = WatchlistStatus.loaded;
        }

        storageService.saveFunds(watchlists);
      },
    );
  }

  void onAddToWatchlistTap({bool val = true}) {
    isAddStock.value = val;
    update();
  }

  void onRemoveFromWatchlistTap(String watchlist, Stocks stock) {
    // watchlists[watchlist]!.where((element) => element.id == stock.id).toList();
    watchlists[watchlist]?.removeWhere((element) => element.id == stock.id);
    storageService.saveFunds(watchlists);
  }

  void onEditWatchlistSubmit(String value, String key) {
    if (creatWatchlistFormKey.currentState!.validate()) {
      if (watchlists.containsKey(key)) {
        watchlists[value] = watchlists.remove(key) ?? [];
        if (Get.isBottomSheetOpen!) {
          Get.until((route) => !Get.isBottomSheetOpen!);
        }
      }
    }
  }

  void removeWatchlist(String key, BuildContext context) {
    sureDelete().then(
      (value) {
        if (value == false) {
          if (Get.isBottomSheetOpen!) {
            return Get.until((route) => !Get.isBottomSheetOpen!);
          }
        }

        if (watchlists.containsKey(key)) {
          watchlists.remove(key) ?? [];
          if (Get.isBottomSheetOpen!) {
            Get.until((route) => !Get.isBottomSheetOpen!);
          }
          tabController.dispose();
          tabController = TabController(
            length: watchlists.length,
            vsync: this,
          );
          tabController.addListener(
            () {
              currentTab.value = tabController.index;
            },
          );
          tabController.animateTo(0);
          currentTab.value = tabController.index;
          khazanSnackbar(context,
              msg: 'Your Watchlist has been deleted successfully');
        }
      },
    );
  }

  Future<bool?> sureDelete() {
    return Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: AppColors.textFieldFillColor, // Dark background
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning icon and text
              Row(
                children: [
                  SvgPicture.asset(AppImages.danger),
                  Expanded(
                    child: Text(
                      "Do you want to delete Watchlist 1?",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Divider line
              Divider(),
              const SizedBox(height: 12),
              // Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // No Button
                  Expanded(
                    child: KhazanaButton(
                      borderColor: AppColors.primaryColor,
                      isActive: false,
                      onPressed: () => Get.back(result: false),
                      child: const Text("No",
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ),
                  Gap(25),
                  // Yes Button
                  Expanded(
                    child: KhazanaButton(
                      onPressed: () {
                        Get.back(result: true);
                      },
                      color: AppColors.red,
                      child: const Text("Yes",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum WatchlistStatus { noWatchlist, loaded, error }
