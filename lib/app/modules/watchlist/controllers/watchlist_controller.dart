import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WatchlistController extends GetxController
    with GetTickerProviderStateMixin {
  RxList watchlists = [].obs;
  final watchlistState = WatchlistStatus.noWatchlist.obs;
  TextEditingController watchlistNameController = TextEditingController();
  GlobalKey<FormState> creatWatchlistFormKey = GlobalKey<FormState>();
  late TabController tabController;
  @override
  void onInit() {
    super.onInit();
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
      },
    );
    Future.delayed(Duration(seconds: 2), () {
      return watchlists.value = [
        'Watchlist1',
        'Watchlist2',
        'Watchlist3',
      ];
    });
  }

  createWatchlist() {
    if (creatWatchlistFormKey.currentState!.validate()) {
      watchlists.add(watchlistNameController.text);
      watchlistNameController.clear();
      Get.back();
    }
  }
}

enum WatchlistStatus { noWatchlist, loaded, error }
