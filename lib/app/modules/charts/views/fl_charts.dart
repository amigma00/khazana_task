// ignore_for_file: deprecated_member_use

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khazana_task/app/constants/app_colors.dart';

class CustomLineChart extends StatelessWidget {
  const CustomLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          backgroundColor: Colors.black,
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return Text('2022', style: _axisTextStyle);
                    case 1:
                      return Text('2023', style: _axisTextStyle);
                    case 2:
                      return Text('2024', style: _axisTextStyle);
                    case 3:
                      return Text('2025', style: _axisTextStyle);
                    default:
                      return Container();
                  }
                },
                reservedSize: 28,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            _buildLineBarData(_blueLineData, AppColors.primaryColor),
            _buildLineBarData(_orangeLineData, AppColors.yellow),
          ],
          lineTouchData: LineTouchData(
            handleBuiltInTouches: true, // Enables dragging
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) => AppColors.textFieldFillColor,
              tooltipBorder:
                  BorderSide(width: .2, color: AppColors.primaryColor),
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  String date = _getFormattedDate(spot.x);
                  return LineTooltipItem(
                    '$date\n',
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text:
                            //  spot.bar.colors.first == Colors.blue
                            //     ?
                            //      "Your Investment: ₹${spot.y.toStringAsFixed(2)}"
                            //     :
                            "Nifty Midcap: ₹${spot.y.toStringAsFixed(2)}",
                        style: TextStyle(
                            // color: spot.bar.colors.first,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  );
                }).toList();
              },
            ),

            touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
              if (event is FlPanUpdateEvent &&
                  response != null &&
                  response.lineBarSpots != null) {
                // Optionally handle dragging behavior if needed
              }
            },
          ),
        ),
      ),
    );
  }

  static const TextStyle _axisTextStyle = TextStyle(
    color: Colors.white54,
    fontSize: 12,
  );

  /// Blue line data
  static final List<FlSpot> _blueLineData = [
    FlSpot(0, 2),
    FlSpot(0.5, 2.5),
    FlSpot(1, 2.2),
    FlSpot(1.5, 3),
    FlSpot(2, 2.8),
    FlSpot(2.5, 3.5),
    FlSpot(3, 4),
  ];

  /// Orange line data
  static final List<FlSpot> _orangeLineData = [
    FlSpot(0, 1),
    FlSpot(0.5, 2),
    FlSpot(1, 1.5),
    FlSpot(1.5, 2.8),
    FlSpot(2, 2.2),
    FlSpot(2.5, 3.2),
    FlSpot(3, 3.8),
  ];

  /// Method to create smooth line chart data
  LineChartBarData _buildLineBarData(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      dotData: FlDotData(show: false),
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 1,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: [color.withOpacity(.12), Color(0xffD9D9D9).withOpacity(0)],
        ),
      ),
    );
  }
}

/// Method to format date based on x-axis value
String _getFormattedDate(double xValue) {
  DateTime baseDate = DateTime(2022, 1, 9); // Starting date
  DateTime currentDate = baseDate.add(Duration(days: (xValue * 365).toInt()));
  return DateFormat('dd-MM-yyyy').format(currentDate);
}
