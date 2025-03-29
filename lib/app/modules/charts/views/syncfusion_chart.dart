// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:khazana_task/app/components/text_extension.dart';
import 'package:khazana_task/app/constants/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class SyncfusionLineChart extends StatelessWidget {
  SyncfusionLineChart(
      {super.key, this.selectedX, this.trackballDetails, required this.isNav});
  final bool isNav;
  final double? selectedX;
  final TrackballDetails? trackballDetails;

  final List<ChartData> data1 = [
    ChartData(DateTime(2022, 1, 1), 949.31),
    ChartData(DateTime(2023, 1, 1), 955),
    ChartData(DateTime(2024, 1, 1), 970),
    ChartData(DateTime(2025, 1, 1), 1000),
  ];

  final List<ChartData> data2 = [
    ChartData(DateTime(2022, 1, 1), 956.72),
    ChartData(DateTime(2023, 1, 1), 965),
    ChartData(DateTime(2024, 1, 1), 975),
    ChartData(DateTime(2025, 1, 1), 1010),
  ];

  final List<ChartData> navData = [
    ChartData(DateTime(2022, 1), 50),
    ChartData(DateTime(2022, 2), 52),
    ChartData(DateTime(2022, 3), 48),
    ChartData(DateTime(2022, 4), 51),
    ChartData(DateTime(2022, 5), 54),
    ChartData(DateTime(2022, 6), 53),
    ChartData(DateTime(2022, 7), 57),
    ChartData(DateTime(2022, 8), 55),
    ChartData(DateTime(2022, 9), 59),
    ChartData(DateTime(2022, 10), 58),
    ChartData(DateTime(2022, 11), 60),
    ChartData(DateTime(2022, 12), 62),
    ChartData(DateTime(2023, 1), 64),
    ChartData(DateTime(2023, 2), 66),
    ChartData(DateTime(2023, 3), 65),
    ChartData(DateTime(2023, 4), 68),
    ChartData(DateTime(2023, 5), 69),
    ChartData(DateTime(2023, 6), 72),
    ChartData(DateTime(2023, 7), 70),
    ChartData(DateTime(2023, 8), 74),
    ChartData(DateTime(2023, 9), 76),
    ChartData(DateTime(2023, 10), 75),
    ChartData(DateTime(2023, 11), 78),
    ChartData(DateTime(2023, 12), 79),
    ChartData(DateTime(2024, 1), 81),
    ChartData(DateTime(2024, 2), 83),
    ChartData(DateTime(2024, 3), 82),
    ChartData(DateTime(2024, 4), 85),
    ChartData(DateTime(2024, 5), 87),
    ChartData(DateTime(2024, 6), 88),
    ChartData(DateTime(2024, 7), 90),
    ChartData(DateTime(2024, 8), 92),
    ChartData(DateTime(2024, 9), 91),
    ChartData(DateTime(2024, 10), 94),
    ChartData(DateTime(2024, 11), 95),
    ChartData(DateTime(2024, 12), 98),
    ChartData(DateTime(2025, 1), 100),
  ];

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      margin: EdgeInsets.zero,
      plotAreaBorderWidth: 0,

      /// X & Y Axis Customization
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat.y(),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        majorTickLines: MajorTickLines(width: 0),
        desiredIntervals: 2,
        axisLine: AxisLine(width: 0),
        majorGridLines: MajorGridLines(width: 0),
        labelStyle: TextStyle(
            color: Colors.white54, fontWeight: FontWeight.w400, fontSize: 10),
      ),
      primaryYAxis: NumericAxis(
        isVisible: false,
        majorGridLines: MajorGridLines(width: 0),
      ),

      /// Adding Data Series
      series: <SplineAreaSeries<ChartData, DateTime>>[
        if (!isNav) ...[
          _buildSeries(data1, AppColors.primaryColor),
          _buildSeries(data2, AppColors.yellow),
        ] else
          _buildSeries(navData, AppColors.nav),
      ],

      /// Draggable Tooltip (Trackball)
      trackballBehavior: TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap,
        tooltipAlignment: ChartAlignment.near,
        tooltipDisplayMode: TrackballDisplayMode.nearestPoint,
        tooltipSettings: InteractiveTooltip(
          enable: true,
          color: Colors.blueGrey.shade900,
          borderRadius: 8,
          textStyle: TextStyle(color: Colors.white),
        ),
        // lineType: TrackballLineType.vertical,
        lineColor: Colors.white54,
        lineDashArray: [5, 5],
        shouldAlwaysShow: true,
        builder: (BuildContext context, TrackballDetails details) {
          /// Get formatted date and values
          String date = DateFormat('dd-MM-yyyy').format(details.point?.x);
          num blueValue = details.groupingModeInfo?.points[0].y ?? 0;
          num orangeValue = details.groupingModeInfo?.points[1].y ?? 0;

          return Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(width: .2, color: AppColors.primaryColor),
              color: AppColors.textFieldFillColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                date.textGilroy400(8, color: Colors.white),
                SizedBox(height: 4),
                if (isNav)
                  _buildLegend("Nav", blueValue, AppColors.nav)
                else ...[
                  _buildLegend("Your Investment", blueValue, Colors.blue),
                  SizedBox(height: 2),
                  _buildLegend("Nifty Midcap", orangeValue, Colors.orange)
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  /// Helper method to build a series with gradient fill
  SplineAreaSeries<ChartData, DateTime> _buildSeries(
      List<ChartData> data, Color color) {
    return SplineAreaSeries<ChartData, DateTime>(
      dataSource: data,
      xValueMapper: (ChartData data, _) => data.date,
      yValueMapper: (ChartData data, _) => data.value,
      splineType: SplineType.natural,
      gradient: LinearGradient(
        colors: [color.withOpacity(.12), Color(0xffD9D9D9).withOpacity(0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderColor: color,
      borderWidth: 1,
    );
  }

  /// Legend Row
  Widget _buildLegend(String label, num value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            width: 16,
            child: Divider(
              color: color,
              thickness: 1,
              height: 1,
            )),
        Gap(8),
        "$label: ₹${value.toStringAsFixed(2)}".textGilroy400(
          8,
        ),
      ],
    );
  }
}

/// Data Model
class ChartData {
  final DateTime date;
  final double value;
  ChartData(this.date, this.value);
}
