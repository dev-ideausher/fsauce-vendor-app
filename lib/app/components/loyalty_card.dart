// import 'package:flutter/material.dart';
// import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
// import 'package:fsauce_vendor_app/app/services/colors.dart';
// import 'package:fsauce_vendor_app/app/services/gradients.dart';
// import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
// import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
// import '../../generated/assets.dart';

// class LoyaltyCard extends StatelessWidget {
//   const LoyaltyCard(
//       {super.key,
//       required this.brandName,
//       required this.offer,
//       required this.brandColor,
//       required this.onAddPressed,
//       required this.width,
//       required this.noOfStamps,
//       required this.brandLogo,
//       required this.textColor});

//   final String brandName;
//   final String offer;
//   final String brandLogo;
//   final Color brandColor, textColor;
//   final double width;
//   final Function onAddPressed;
//   final int noOfStamps;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: noOfStamps < 5 ? 200.kh : 260.kh,
//       width: width,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8), color: brandColor),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 height: 48,
//                 width: 48,
//                 padding: EdgeInsets.all(6.kw),
//                 margin: EdgeInsets.only(top: 16.kw, left: 16.kw),
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8.kw)),
//                 child: Center(
//                   child: CommonImageView(
//                     url: brandLogo,
//                   ),
//                 ),
//               ),
//               16.kwidthBox,
//               Expanded(
//                 child: Text(
//                   brandName,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyleUtil.manrope20w700(color: textColor),
//                 ),
//               ),
//               Container(
//                 height: 37.kh,
//                 width: 90.kw,
//                 decoration: BoxDecoration(
//                     color: context.white,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(4),
//                         bottomLeft: Radius.circular(4))),
//                 child: Center(
//                     child: Text(
//                   "0/$noOfStamps Points",
//                   style: TextStyleUtil.manrope14w500(),
//                 )),
//               )
//             ],
//           ),
//           const Spacer(),
//           10.kheightBox,
//           Container(
//             height: noOfStamps < 5 ? 120.kh : 180.kh,
//             width: width,
//             padding: EdgeInsets.only(bottom: 16.kw, left: 16.kw, right: 16.kw),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8.kw),
//                 gradient: GradientUtil.shadowGradient2),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Wrap(
//                   runSpacing: 10.kh,
//                   children: [
//                     SizedBox(
//                       height: 50,
//                       child: ListView.separated(
//                           shrinkWrap: true,
//                           scrollDirection: Axis.horizontal,
//                           itemBuilder: (ctx, index) {
//                             return Container(
//                               height: 48,
//                               width: 48,
//                               decoration: BoxDecoration(
//                                   color: context.black07,
//                                   borderRadius: BorderRadius.circular(8.kw)),
//                               child: Center(
//                                 child: Icon(
//                                   Icons.check,
//                                   color: context.black04,
//                                   size: 28,
//                                 ),
//                               ),
//                             );
//                           },
//                           separatorBuilder: (ctx, index) {
//                             return 4.kwidthBox;
//                           },
//                           itemCount: noOfStamps),
//                     ),
//                     10.kwidthBox,
//                     Container(
//                       height: 48,
//                       width: 48,
//                       decoration: BoxDecoration(
//                           color: context.black07,
//                           borderRadius: BorderRadius.circular(8.kw)),
//                       child: Center(
//                         child: CommonImageView(
//                           svgPath: Assets.svgsGiftIcon,
//                           height: 28.kh,
//                           width: 28.kw,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 24.kheightBox,
//                 Text(
//                   offer,
//                   style: TextStyleUtil.manrope16w500(color: textColor),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/gradients.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import '../../generated/assets.dart';

class LoyaltyCard extends StatelessWidget {
  const LoyaltyCard({
    super.key,
    required this.brandName,
    required this.offer,
    required this.brandColor,
    required this.onAddPressed,
    required this.noOfStamps,
    required this.brandLogo,
    required this.textColor,
  });

  final String brandName;
  final String offer;
  final String brandLogo;
  final Color brandColor, textColor;
  final Function onAddPressed;
  final int noOfStamps;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: brandColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ---------------- HEADER ----------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 48.kh,
                width: 48.kw,
                padding: EdgeInsets.all(4.kw),
                margin: EdgeInsets.only(top: 16.kh, left: 16.kw),
                decoration: BoxDecoration(
                  color: context.white,
                  borderRadius: BorderRadius.circular(8.kh),
                ),
                child: CommonImageView(url: brandLogo),
              ),
              16.kwidthBox,
              Expanded(
                child: Text(
                  brandName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleUtil.manrope20w700(color: textColor),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(12, 8, 8, 8),
                decoration: BoxDecoration(
                  color: context.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: Text(
                    "0/$noOfStamps Points",
                    style: TextStyleUtil.manrope14w500(),
                  ),
                ),
              ),
            ],
          ),
          24.kheightBox,

          /// ---------------- STAMPS AREA ----------------
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.kw),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 16.kh,
                crossAxisSpacing: 16.kw,
              ),
              itemCount: noOfStamps + 1, // stamps + gift
              itemBuilder: (context, index) {
                final bool isGift = index == noOfStamps;

                return isGift ? _giftBox(context) : _stampBox(context);
              },
            ),
          ),

          /// -------- OFFER TEXT --------
          Container(
            width: double.infinity,
            decoration: BoxDecoration(gradient: GradientUtil.shadowGradient2),
            padding: EdgeInsetsGeometry.symmetric(
                horizontal: 12.kw, vertical: 24.kh),
            child: Text(
              offer,
              style: TextStyleUtil.manrope16w500(color: textColor),
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- STAMP BOX ----------------
  Widget _stampBox(BuildContext context) {
    return Container(
      height: 48.kh,
      width: 48.kw,
      decoration: BoxDecoration(
        color: context.black07,
        borderRadius: BorderRadius.circular(8.kw),
      ),
      child: Center(
        child: Icon(
          Icons.check,
          color: context.black04,
          size: 28,
        ),
      ),
    );
  }

  /// ---------------- GIFT BOX ----------------
  Widget _giftBox(BuildContext context) {
    return Container(
      height: 48.kw,
      width: 48.kw,
      decoration: BoxDecoration(
        color: context.black07,
        borderRadius: BorderRadius.circular(8.kw),
      ),
      child: Center(
        child: CommonImageView(
          svgPath: Assets.svgsGiftIcon,
          height: 28.kh,
          width: 28.kw,
        ),
      ),
    );
  }
}
