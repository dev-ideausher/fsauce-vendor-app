
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
    // Extract labels and values
    final xLabels = graphData.map((e) => e.x).toList();
    // Handle empty data gracefully
    final maxY = graphData.isEmpty 
        ? 100.0 
        : (graphData.map((e) => e.y).reduce((a, b) => a > b ? a : b) / 20).ceil() * 20;

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
                maxY: maxY.toDouble(),
                minY: 0,
                gridData: FlGridData(
                  drawHorizontalLine: true,
                  horizontalInterval: 20,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.3),
                    strokeWidth: 0.5,
                  ),
                ),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) => Text(
                        value.toInt().toString(),
                        style: const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= xLabels.length) return const SizedBox.shrink();
                        return Text(
                          xLabels[index],
                          style: const TextStyle(fontSize: 12, color: Colors.black),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(graphData.length, (index) {
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: graphData[index].y,
                        color: barColor,
                        width: 14, // similar to width: 0.2 in Syncfusion
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
