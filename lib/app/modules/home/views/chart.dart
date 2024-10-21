import 'package:custom_syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

import '../../../components/empty_widget.dart';
import '../../../constants/string_constant.dart';
import '../../../models/dashboard_weekly_data_model.dart';

class CouponAnalysisCard extends StatefulWidget {
  const CouponAnalysisCard(
      {super.key, required this.title, required this.graphData});

  final String title;
  final List<ChartData> graphData;

  @override
  State<CouponAnalysisCard> createState() => _CouponAnalysisCardState();
}

class _CouponAnalysisCardState extends State<CouponAnalysisCard> {
  //late TooltipBehavior _tooltip;

  @override
  void initState() {
    // _tooltip = TooltipBehavior(enable: true);
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
                labelStyle: const TextStyle(
                  fontSize: 12, // Adjust the font size as needed
                  color: Colors.black,
                ),
                majorGridLines: const MajorGridLines(width: 0),
              ),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 80,
                interval: 20,
                labelStyle: const TextStyle(
                  fontSize: 12, // Adjust the font size as needed
                  color: Colors.black,
                ),
                majorGridLines: const MajorGridLines(width: 0.5),
              ),
              // tooltipBehavior: _tooltip,
              series: <CartesianSeries<ChartData, String>>[
                ColumnSeries<ChartData, String>(
                  dataSource: widget.graphData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: 'Coupons',
                  color: context.primary01,
                  width: 0.2, // Set the bar width here
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}
