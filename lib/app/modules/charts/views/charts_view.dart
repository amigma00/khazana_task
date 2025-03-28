import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:khazana_task/app/components/text_extension.dart';
import 'package:khazana_task/app/constants/app_colors.dart';
import 'package:khazana_task/app/models/stock_model.dart';

import '../controllers/charts_controller.dart';

class ChartsView extends GetView<ChartsController> {
  final Stocks stocks;
  const ChartsView({
    super.key,
    required this.stocks,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChartsView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        children: [
          'Motilal Oswal Midcap Direct Growth '.textGilroy400(18),
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
                    border:
                        Border.all(color: AppColors.textFieldBorder, width: 1)),
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
        ],
      ),
    );
  }
}
