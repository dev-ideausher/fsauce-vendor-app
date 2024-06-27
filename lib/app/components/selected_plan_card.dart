import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

class SelectedPlanCard extends StatelessWidget {
  const SelectedPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88.kh,
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Center(
        child: Row(
          children: <Widget>[
          Container(
              height: 84,
              width: 84,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffFFEAEA)
              ),
              child: Center(child: Icon(Icons.monetization_on_outlined, color: context.primary01, size: 32.kh,)),
            ),
            20.kwidthBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(StringConstant.silverPlan, style: TextStyleUtil.manrope16w600(),),
              4.kheightBox,
              Row(
                  children: <Widget>[
                    Text(
                      "\$ 500",
                      style: TextStyleUtil.manrope18w600(color: context.primary01),
                    ),
                    Text(
                      "/${StringConstant.year.toLowerCase()}",
                      style: TextStyleUtil.manrope18w600(color: context.black04),
                    )
                  ],),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
