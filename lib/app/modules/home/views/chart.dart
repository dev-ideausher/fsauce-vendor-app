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
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartData {
  final String x;
  final double y;
  ChartData(this.x, this.y);
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

    // Max value in thousands
    final maxRawY = graphData.isEmpty
        ? 10.0
        : graphData.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    final maxY = (maxRawY / 1000).ceilToDouble();

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
                maxY: maxY,
                minY: 0,
                gridData: FlGridData(
                  horizontalInterval: 1,
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
                      interval: 1,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        if (value == 0) return const Text('0');
                        return Text(
                          '${value.toInt()}K',
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
                          xLabels[index].split(' ').first,
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
                  final scaledY = graphData[index].y / 1000;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: scaledY,
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
