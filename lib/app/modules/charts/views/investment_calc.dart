import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:khazana_task/app/components/text_extension.dart';
import 'package:khazana_task/app/constants/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InvestmentController extends GetxController {
  var investmentAmount = 1.0.obs;
  var isOneTime = true.obs;
}

class InvestmentCalculator extends StatelessWidget {
  final InvestmentController controller = Get.put(InvestmentController());

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: AppColors.textFieldFillColor,
          border: Border.all(width: .5, color: AppColors.textFieldBorder),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                'If you invested'.textGilroy400(14),
                Gap(9),
                Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(
                          () => '₹ ${controller.investmentAmount.value} L'
                              .textGilroy400(14),
                        ),
                        Gap(7),
                        Icon(
                          Icons.edit_outlined,
                          size: 15,
                          color: AppColors.labelGrey2,
                        )
                      ],
                    ),
                    Divider()
                  ],
                ),
                Gap(38),
                Expanded(
                  flex: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: AppColors.textFieldBorder, width: .5)),
                    child: DefaultTabController(
                        length: 2,
                        child: TabBar(
                            labelPadding: EdgeInsets.zero,
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerHeight: 0,
                            indicator: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(4)),
                            indicatorWeight: 3,
                            tabs: List.generate(
                              2,
                              (index) => Tab(
                                height: 23,
                                child: ['1-Time', 'Monthly SIP'][index]
                                    .textGilroy400(9),
                              ),
                            )).paddingAll(4)),
                  ),
                )
              ],
            ),
            Gap(15),
            Obx(() => Slider(
                  padding: EdgeInsets.zero,
                  value: controller.investmentAmount.value,
                  min: 1,
                  max: 10,
                  divisions: 9,
                  activeColor: AppColors.primaryColor,
                  inactiveColor: AppColors.primaryColor.withValues(alpha: .2),
                  onChanged: (value) {
                    controller.investmentAmount.value = value;
                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                '₹ 1 L'.textGilroy400(9),
                '₹ 10 L'.textGilroy400(9),
              ],
            ),
            Gap(32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "This Fund's past returns".textGilroy400(12),
                    Gap(4),
                    'Profit % (Absolute Return)'
                        .textGilroy400(9, color: AppColors.textFieldBorder)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    '₹ ${controller.investmentAmount.value} L'
                        .textGilroy400(12, color: AppColors.green),
                    Gap(4),
                    '355.3%'.textGilroy400(9)
                  ],
                ),
              ],
            ),
            Gap(32),
            SfCartesianChart(
              plotAreaBorderWidth: 0,
              margin: EdgeInsets.zero,
              primaryXAxis: CategoryAxis(
                axisLine: AxisLine(width: 0),
                majorTickLines: MajorTickLines(width: 0),
                majorGridLines: MajorGridLines(width: 0),
                labelStyle: TextStyle(color: Colors.white),
              ),
              primaryYAxis: NumericAxis(
                isVisible: false, // Hides the Y-axis labels
              ),
              series: [
                StackedColumnSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.category,
                  yValueMapper: (ChartData data, _) => data.baseValue,
                  color: AppColors.investCalcGrey, // Bottom dark part
                ),
                StackedColumnSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.category,
                  yValueMapper: (ChartData data, _) => data.growthValue,
                  color: AppColors.investCalcGreen, // Top green part
                  dataLabelMapper: (ChartData data, _) =>
                      data.growthValue.toString(), // Labels on top
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    offset: Offset(0, 30),
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 9),
                    labelAlignment: ChartDataLabelAlignment.top,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final List<ChartData> chartData = [
  ChartData('Saving A/C', 100000, 19000), // Base + Green Portion
  ChartData('Category Avg.', 200000, 163000),
  ChartData('Direct Plan', 200000, 255000),
];

class ChartData {
  final String category;
  final double baseValue;
  final double growthValue;

  ChartData(this.category, this.baseValue, this.growthValue);
}
