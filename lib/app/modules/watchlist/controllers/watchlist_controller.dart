import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  }

  createWatchlist() {
    if (creatWatchlistFormKey.currentState!.validate()) {
      watchlists[watchlistNameController.text] = [];
      watchlistNameController.clear();
      Get.back();
    }
  }

  watchlistMapListener() {
    watchlists.listen(
      (p0) {
        if (p0.isEmpty) {
          watchlistState.value = WatchlistStatus.noWatchlist;
        } else {
          watchlistState.value = WatchlistStatus.loaded;
        }
        tabController = TabController(
          length: watchlists.length,
          vsync: this,
        );

        storageService.saveFunds(watchlists);
      },
    );
  }

  onAddToWatchlistTap({bool val = true}) {
    isAddStock.value = val;
    update();
  }
}

enum WatchlistStatus { noWatchlist, loaded, error }
