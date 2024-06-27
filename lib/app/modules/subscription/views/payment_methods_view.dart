import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/subscription/controllers/subscription_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

class PaymentMethodsView extends GetView<SubscriptionController> {
  const PaymentMethodsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          StringConstant.paymentMethod,
          style: TextStyleUtil.manrope18w600(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            32.kheightBox,
            Text(
              StringConstant.savedCards,
              style: TextStyleUtil.manrope16w600(),
            ),
            16.kheightBox,
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return Container(
                    height: 58.kh,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    child: Center(
                      child: ListTile(
                        leading: Container(
                          height: 44.kh,
                          width: 48.kh,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.black07,
                          ),
                        ),
                        title: Text("******** 34 567",
                            style: TextStyleUtil.manrope14w400()),
                        trailing: Radio(
                          activeColor: context.primary01,
                          value: null,
                          groupValue: null,
                          onChanged: (Null? value) {},
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return 8.kheightBox;
                },
                itemCount: 3),
            32.kheightBox,
            Text(
              StringConstant.addPaymentMethods,
              style: TextStyleUtil.manrope16w600(),
            ),
            16.kheightBox,
            ListView(
              shrinkWrap: true,
              children: [
                InkWell(
                  onTap: () {
                    controller.goToCardDetailsView();
                  },
                  child: Container(
                    height: 60.kh,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    child: Center(
                      child: ListTile(
                        leading: Container(
                          height: 44.kh,
                          width: 48.kh,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.black07,
                          ),
                        ),
                        title: Text(StringConstant.creditDebitCard,
                            style: TextStyleUtil.manrope14w500()),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios, size: 16,),
                        )
                      ),
                    ),
                  ),
                ),
                8.kheightBox,
                InkWell(
                  onTap: () {
                    //ToDo: Implement apply pay.
                  },
                  child: Container(
                    height: 60.kh,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    child: Center(
                      child: ListTile(
                        leading: Container(
                          height: 44.kh,
                          width: 48.kh,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.black07,
                          ),
                        ),
                        title: Text(StringConstant.applePay,
                            style: TextStyleUtil.manrope14w500()),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios, size: 16,),
                        )
                      ),
                    ),
                  ),
                ),
                8.kheightBox,
                InkWell(
                  onTap: () {
                    //ToDo: Implement google pay.
                  },
                  child: Container(
                    height: 60.kh,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    child: Center(
                      child: ListTile(
                        leading: Container(
                          height: 44.kh,
                          width: 48.kh,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.black07,
                          ),
                        ),
                        title: Text(StringConstant.googlePay,
                            style: TextStyleUtil.manrope14w500()),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios, size: 16,),
                        )
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomRedElevatedButton(
          buttonText: StringConstant.save,
          height: 56.kh,
          width: MediaQuery.of(context).size.width * 0.9,
          onPressed: () {
            controller.goToCardDetailsView();
          }),
    );
  }
}
