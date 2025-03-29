import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InvestmentController extends GetxController {
  var investmentAmount = 100000.0.obs;
  var isOneTime = true.obs;
}

class InvestmentCalculator extends StatelessWidget {
  final InvestmentController controller = Get.put(InvestmentController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'If you invested',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Obx(() => Row(
                children: [
                  Text(
                    '₹ ${controller.investmentAmount.value ~/ 1000} L',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.edit, color: Colors.white54, size: 16),
                ],
              )),
          Obx(() => Slider(
                value: controller.investmentAmount.value,
                min: 100000,
                max: 10000000,
                divisions: 9,
                activeColor: Colors.blue,
                inactiveColor: Colors.white24,
                onChanged: (value) {
                  controller.investmentAmount.value = value;
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('₹ 1 L', style: TextStyle(color: Colors.white54)),
              Text('₹ 10 L', style: TextStyle(color: Colors.white54)),
            ],
          ),
          Obx(() => ToggleButtons(
                borderColor: Colors.white24,
                fillColor: Colors.blue,
                selectedColor: Colors.white,
                borderRadius: BorderRadius.circular(10),
                isSelected: [
                  controller.isOneTime.value,
                  !controller.isOneTime.value
                ],
                onPressed: (index) {
                  controller.isOneTime.value = index == 0;
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('1-Time', style: TextStyle(fontSize: 16)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Monthly SIP', style: TextStyle(fontSize: 16)),
                  ),
                ],
              )),
          SizedBox(height: 20),
          Text(
            "This Fund's past returns",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <CartesianSeries>[
              ColumnSeries<ChartData, String>(
                dataSource: [
                  ChartData('Saving A/C', 119000, Colors.green),
                  ChartData('Category Avg.', 363000, Colors.green),
                  ChartData('Direct Plan', 455000, Colors.green),
                ],
                xValueMapper: (ChartData data, _) => data.label,
                yValueMapper: (ChartData data, _) => data.value,
                pointColorMapper: (ChartData data, _) => data.color,
                dataLabelSettings: DataLabelSettings(isVisible: true),
              )
            ],
          ),
          Spacer(),
          ToggleButtons(
            borderColor: Colors.white24,
            fillColor: Colors.blue,
            selectedColor: Colors.white,
            borderRadius: BorderRadius.circular(10),
            isSelected: [false, false, false, false, false, true],
            children: [
              Text('1M'),
              Text('3M'),
              Text('6M'),
              Text('1Y'),
              Text('3Y'),
              Text('MAX')
            ],
            onPressed: (index) {},
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String label;
  final double value;
  final Color color;

  ChartData(this.label, this.value, this.color);
}
