import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:khazana_task/app/components/khazana_button.dart';
import 'package:khazana_task/app/components/khazana_snackbar.dart';
import 'package:khazana_task/app/components/text_extension.dart';
import 'package:khazana_task/app/constants/app_colors.dart';
import 'package:khazana_task/app/models/stock_model.dart';
import 'package:khazana_task/app/modules/charts/views/fl_charts.dart';
import 'package:khazana_task/app/modules/charts/views/investment_calc.dart';

import 'package:khazana_task/app/modules/charts/views/syncfusion_chart.dart';

import '../controllers/charts_controller.dart';

class ChartsView extends GetView<ChartsController> {
  final Stocks stocks;
  const ChartsView({
    super.key,
    required this.stocks,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ChartsView'),
          centerTitle: true,
        ),
        bottomNavigationBar: ColoredBox(
            color: Colors.black,
            child: Row(
              children: [
                Expanded(
                  child: KhazanaButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'Sell'.textGilroy400(12),
                        Gap(6),
                        Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ),
                Gap(24),
                Expanded(
                  child: KhazanaButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'Invest More'.textGilroy400(12),
                        Gap(6),
                        Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 26, vertical: 16)),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          children: [
            stocks.name.toString().textGilroy400(18),
            Gap(8),
            Row(
              children: [
                Row(
                  children: [
                    'Nav'.textGilroy400(12, color: AppColors.labelGrey),
                    Gap(4),
                    '₹${stocks.nav?.toStringAsFixed(2)}'.textGilroy400(14)
                  ],
                ),
                Gap(12),
                '|'.textGilroy400(20, color: AppColors.labelGrey),
                Gap(12),
                '1D'.textGilroy400(12, color: AppColors.labelGrey),
                Gap(2),
                '${stocks.change?.day?.toStringAsFixed(2)}%'
                    .textGilroy400(12, color: AppColors.green),
                Gap(8),
                Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.red,
                    ),
                    '-3.7'.textGilroy400(14, color: AppColors.red)
                  ],
                )
              ],
            ),
            Gap(24),
            IntrinsicHeight(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: AppColors.textFieldBorder, width: 1)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            'Invested'
                                .textGilroy400(14, color: AppColors.labelGrey2),
                            '₹1.3k'.textGilroy400(14)
                          ],
                        ),
                      ),
                      VerticalDivider()
                          .paddingSymmetric(vertical: 4, horizontal: 6),
                      Expanded(
                        child: Column(
                          children: [
                            'Invested'
                                .textGilroy400(14, color: AppColors.labelGrey2),
                            '₹1.3k'.textGilroy400(14)
                          ],
                        ),
                      ),
                      VerticalDivider()
                          .paddingSymmetric(vertical: 4, horizontal: 6),
                      Expanded(
                        child: Column(
                          children: [
                            'Invested'
                                .textGilroy400(14, color: AppColors.labelGrey2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                '₹1.3k'.textGilroy400(14),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColors.red,
                                ),
                                '-3.7'.textGilroy400(14, color: AppColors.red)
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 4, vertical: 10)),
            ),
            Gap(24),
            Row(
              children: [
                Obx(
                  () => controller.isNav.value
                      ? Row(
                          children: [
                            SizedBox(
                                width: 16,
                                child: Divider(
                                  color: AppColors.nav,
                                  thickness: 1,
                                  height: 1,
                                )),
                            Gap(8),
                            'NAV'.textGilroy400(10, color: AppColors.nav),
                            Gap(8),
                            '23.6% (104.2)'
                                .textGilroy400(12, color: AppColors.nav)
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width: 16,
                                    child: Divider(
                                      color: AppColors.primaryColor,
                                      thickness: 1,
                                      height: 1,
                                    )),
                                Gap(8),
                                'Your Investments'.textGilroy400(10,
                                    color: AppColors.primaryColor),
                                Gap(8),
                                '-12.97%'.textGilroy400(12,
                                    color: AppColors.primaryColor)
                              ],
                            ),
                            Gap(4),
                            Row(
                              children: [
                                SizedBox(
                                    width: 16,
                                    child: Divider(
                                      color: AppColors.yellow,
                                      thickness: 1,
                                    )),
                                Gap(8),
                                'Nifty Midcap 150'
                                    .textGilroy400(10, color: AppColors.yellow),
                                Gap(8),
                                '-12.97%'
                                    .textGilroy400(12, color: AppColors.yellow)
                              ],
                            )
                          ],
                        ),
                ),
                Spacer(),
                Obx(
                  () => KhazanaButton(
                    radius: 4,
                    isActive: false,
                    borderColor:
                        controller.isNav.value ? AppColors.primaryColor : null,
                    onPressed: () => controller.isNav.toggle(),
                    padding: EdgeInsets.zero,
                    child: 'NAV'
                        .textGilroy400(9)
                        .paddingSymmetric(horizontal: 14, vertical: 8),
                  ),
                )
              ],
            ),
            // CustomLineChart(),
            Obx(() => SyncfusionLineChart(isNav: controller.isNav.value)),
            Gap(12),
            DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border:
                      Border.all(color: AppColors.textFieldBorder, width: .5)),
              child: DefaultTabController(
                  length: 6,
                  child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerHeight: 0,
                      indicator: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(4)),
                      indicatorWeight: 3,
                      tabs: List.generate(
                        6,
                        (index) => Tab(
                          height: 26,
                          child: ['1M', '3M', '6M', '1Y', '3Y', 'MAX'][index]
                              .textGilroy400(12),
                        ),
                      ))).paddingAll(4),
            ),
            Gap(45),
            InvestmentCalculator()
          ],
        ),
      ),
    );
  }
}
