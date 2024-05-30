import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CouponAnalysisCard extends StatefulWidget {
  const CouponAnalysisCard({super.key, required this.title});
  final String title;

  @override
  State<CouponAnalysisCard> createState() => _CouponAnalysisCardState();
}

class _CouponAnalysisCardState extends State<CouponAnalysisCard> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('Sun', 20),
      _ChartData('Mon', 40),
      _ChartData('Tue', 30),
      _ChartData('Wed', 30),
      _ChartData('Thu', 60),
      _ChartData('Fri', 50),
      _ChartData('Sat', 40),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,
                style: TextStyleUtil.manrope14w600(color: context.black02)),
            16.kheightBox,
            SfCartesianChart(
              backgroundColor: Colors.white,
              primaryXAxis: CategoryAxis(
                labelStyle: TextStyle(
                  fontSize: 12, // Adjust the font size as needed
                  color: Colors.black,
                ),
                majorGridLines: MajorGridLines(width: 0),
              ),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 80,
                interval: 20,
                labelStyle: TextStyle(
                  fontSize: 12, // Adjust the font size as needed
                  color: Colors.black,
                ),
                majorGridLines: MajorGridLines(width: 0.5),
              ),
              tooltipBehavior: _tooltip,
              series: <CartesianSeries<_ChartData, String>>[
                ColumnSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Coupons',
                  color: context.primary01,
                  width: 0.2, // Set the bar width here
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
