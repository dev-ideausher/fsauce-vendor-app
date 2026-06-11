import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/models/all_plan_model.dart';
import 'package:fsauce_vendor_app/app/modules/subscription/controllers/subscription_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

class PlanCard extends StatelessWidget {
  final AllPlanModelData plan;

  const PlanCard({required this.plan, super.key});

  static const double _radioGutter = 40;

  String _formatPrice() {
    final p = (plan.price ?? 0).toDouble();
    return p.toStringAsFixed(2);
  }

  String _billingSuffix() {
    final f = plan.billedFrequency?.toLowerCase() ?? '';
    if (f.contains('year')) return 'year';
    if (f.contains('month')) return 'month';
    if (f.isNotEmpty) return plan.billedFrequency!.trim();
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final List<String?> features = plan.features ?? [];
    final controller = Get.find<SubscriptionController>();
    final primary = context.primary01;

    return Container(
        padding: EdgeInsets.fromLTRB(16.kw, 16.kh, 16.kw, 20.kh),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.kw),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Obx(() {
              final isCurrent = controller.isCurrentSubscriptionPlan(plan);
              return Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      _radioGutter,
                      2.kh,
                      isCurrent ? 118.kw : _radioGutter,
                      0,
                    ),
                    child: Text(
                      plan.title ?? "",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleUtil.manrope18w600(color: context.black01),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Radio<AllPlanModelData>(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      activeColor: primary,
                      value: plan,
                      groupValue: controller.selectedPlan.value,
                      onChanged: (AllPlanModelData? model) {
                        if (model != null) {
                          controller.selectedPlan.value = model;
                        }
                      },
                    ),
                  ),
                  if (isCurrent)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.kw,
                          vertical: 4.kh,
                        ),
                        decoration: BoxDecoration(
                          color: context.primary03,
                          borderRadius: BorderRadius.circular(6.kw),
                        ),
                        child: Text(
                          StringConstant.currentPlan,
                          textAlign: TextAlign.center,
                          style: TextStyleUtil.manrope12w400(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
            14.kheightBox,
            if (features.isNotEmpty) ...[
              ...List.generate(features.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.kh),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: (MediaQuery.sizeOf(context).width - 32.kw)
                            .clamp(200.0, 520.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 6.kh),
                            child: Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: context.black03,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          10.kwidthBox,
                          Expanded(
                            child: Text(
                              features[index] ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyleUtil.manrope14w400(
                                color: context.black03,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
            20.kheightBox,
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "\$ ${_formatPrice()}",
                    style: TextStyleUtil.manrope20w600(color: primary),
                  ),
                  Text(
                    _billingSuffix().isEmpty
                        ? ""
                        : " / ${_billingSuffix()}",
                    style: TextStyleUtil.manrope20w600(color: context.black04),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
