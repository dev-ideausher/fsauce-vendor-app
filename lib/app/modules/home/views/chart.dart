// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class ChartData {
//   final String x;
//   final double y;
//   ChartData(this.x, this.y);
// }

// class FlBarChartWidget extends StatelessWidget {
//   final String title;
//   final List<ChartData> graphData;
//   final Color barColor;

//   const FlBarChartWidget({
//     super.key,
//     required this.title,
//     required this.graphData,
//     required this.barColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Extract labels and values
//     final xLabels = graphData.map((e) => e.x).toList();
//     // Handle empty data gracefully
//     final maxY = graphData.isEmpty
//         ? 100.0
//         : (graphData.map((e) => e.y).reduce((a, b) => a > b ? a : b) / 20)
//                 .ceil() *
//             20;

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: 14,
//               color: Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 16),
//           AspectRatio(
//             aspectRatio: 1.6,
//             child: BarChart(
//               BarChartData(
//                 maxY: maxY.toDouble(),
//                 minY: 0,
//                 gridData: FlGridData(
//                   drawVerticalLine: true,
//                   verticalInterval: 20,
//                   getDrawingVerticalLine: (value) => FlLine(
//                     color: Colors.grey.withValues(alpha: 0.3),
//                     strokeWidth: 0.3,
//                   ),
//                 ),
//                 titlesData: FlTitlesData(
//                   rightTitles: const AxisTitles(
//                       sideTitles: SideTitles(showTitles: false)),
//                   topTitles: const AxisTitles(
//                       sideTitles: SideTitles(showTitles: false)),
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       interval: 20,
//                       reservedSize: 30,
//                       getTitlesWidget: (value, meta) => Text(
//                         '${value.toInt().toString()}K',
//                         style: const TextStyle(
//                             fontSize: 12, color: Colors.black54),
//                       ),
//                     ),
//                   ),
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       getTitlesWidget: (value, meta) {
//                         final index = value.toInt();
//                         if (index < 0 || index >= xLabels.length) {
//                           return const SizedBox.shrink();
//                         }
//                         return Text(
//                           xLabels[index].split(' ').first,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: Colors.black54,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 borderData: FlBorderData(show: false),
//                 barGroups: List.generate(graphData.length, (index) {
//                   return BarChartGroupData(
//                     x: index,
//                     barRods: [
//                       BarChartRodData(
//                         toY: graphData[index].y,
//                         color: barColor,
//                         width: 14, // similar to width: 0.2 in Syncfusion
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ],
//                   );
//                 }),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartData {
  final String x;
  final double y;
  ChartData(this.x, this.y);
}

/// X-axis labels for dashboard bars.
///
/// - **Week tab** (`lastWeek`): daily points like `Tue Apr 14 2026` → weekday **Tue**.
/// - **Month tab** (`lastMonth`): API sends week ranges `Fri Apr 10 - Thu Apr 16` → **month + day**
///   of the week start (**Apr 10**) so each bar is a distinct week within the month.
/// - **Year tab** (`lastYear`): **Jan**, **Feb**, …
String formatDashboardChartXLabel(String raw) {
  final trimmed = raw.trim();
  if (trimmed.contains(' - ')) {
    final left = trimmed.split(' - ').first.trim();
    final parts = left.split(RegExp(r'\s+'));
    if (parts.length >= 3) {
      return '${parts[1]} ${parts[2]}';
    }
  }
  final first = trimmed.split(RegExp(r'\s+')).first;
  return first.isEmpty ? raw : first;
}

class FlBarChartWidget extends StatelessWidget {
  final String title;
  final List<ChartData> graphData;
  final Color barColor;

  const FlBarChartWidget({
    super.key,
    required this.title,
    required this.graphData,
    required this.barColor,
  });

  @override
  Widget build(BuildContext context) {
    final xLabels = graphData.map((e) => e.x).toList();

    final maxRawY = graphData.isEmpty
        ? 0.0
        : graphData.map((e) => e.y).reduce((a, b) => a > b ? a : b);

    // API returns raw counts (e.g. 12); old logic assumed thousands-only and /1000 made bars invisible.
    final useThousands = maxRawY >= 1000;
    final double chartMaxY;
    if (graphData.isEmpty) {
      chartMaxY = 10;
    } else if (maxRawY <= 0) {
      chartMaxY = 10;
    } else if (useThousands) {
      chartMaxY = math.max(1.0, (maxRawY / 1000).ceilToDouble());
    } else {
      chartMaxY = math.max(1.0, maxRawY.ceilToDouble());
    }

    final yInterval = useThousands
        ? (chartMaxY <= 5 ? 1.0 : (chartMaxY / 5).ceilToDouble())
        : (chartMaxY <= 5 ? 1.0 : (chartMaxY / 4).ceilToDouble());

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 1.6,
            child: BarChart(
              BarChartData(
                maxY: chartMaxY,
                minY: 0,
                gridData: FlGridData(
                  horizontalInterval: yInterval,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.withValues(alpha: 0.3),
                    strokeWidth: 0.3,
                  ),
                  drawHorizontalLine: true,
                  drawVerticalLine: false,
                ),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: yInterval,
                      reservedSize: 36,
                      getTitlesWidget: (value, meta) {
                        if (value == 0) return const Text('0');
                        if (useThousands) {
                          return Text(
                            '${value.toInt()}K',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black54),
                          );
                        }
                        return Text(
                          value == value.roundToDouble()
                              ? value.toInt().toString()
                              : value.toStringAsFixed(1),
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black54),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= xLabels.length) {
                          return const SizedBox.shrink();
                        }
                        return Text(
                          formatDashboardChartXLabel(xLabels[index]),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(graphData.length, (index) {
                  final yVal = graphData[index].y;
                  final toY = useThousands ? yVal / 1000.0 : yVal;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: toY,
                        color: barColor,
                        width: 14,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  );
                }),
                // Add tooltip with raw value
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final rawValue = graphData[groupIndex].y;
                      return BarTooltipItem(
                        rawValue.toString(),
                        const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
