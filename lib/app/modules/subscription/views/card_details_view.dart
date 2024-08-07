import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fsauce_vendor_app/app/components/added_successfull_bottomsheet.dart';
import 'package:fsauce_vendor_app/app/components/custom_red_elevated_button.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/modules/subscription/controllers/subscription_controller.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';

class CardDetailsView extends GetView<SubscriptionController>{
  CardDetailsView({super.key});

  @override
  Widget build(BuildContext context){
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
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 16.kh),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                16.kheightBox,
                Text(StringConstant.addNewCard, style: TextStyleUtil.manrope18w600(),),
                32.kheightBox,
                Text(StringConstant.cardNumber, style: TextStyleUtil.manrope14w500(),),
                16.kheightBox,
                Container(
                  height: 53.kh,
                  padding: const EdgeInsets.only(left: 12),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: context.black05)
                  ),
                  child: Center(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controller.cardNumberController,
                      validator: (String? val){
                        if(val == null || val.isEmpty){
                          return StringConstant.cardNoEmpty;
                        } else if(val.length < 13){
                          return StringConstant.less13;
                        } else if(!val.isNumericOnly){
                          return StringConstant.onlyNoAllowed;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: StringConstant.enterFeatures,
                        hintStyle: TextStyleUtil.manrope14w400()
                      ),
                    ),
                  ),
                ),
                16.kheightBox,
                Row(
                  children: <Widget>[
                    Text(StringConstant.expires, style: TextStyleUtil.manrope14w500(),),
                    Expanded(child: Container(),),
                    Text(StringConstant.cvv, style: TextStyleUtil.manrope14w500(),),
                    Expanded(child: Container(),),
                  ],
                ),
                16.kheightBox,
                Row(
                  children: <Widget>[
                    Container(
                      height: 53.kh,
                      padding: EdgeInsets.only(left: 12.kw),
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: context.black05)
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: controller.expiresController,
                          validator: (String? val){
                            if(val == null || val.isEmpty){
                              return StringConstant.expiryDateEmpty;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: StringConstant.enterFeatures,
                              hintStyle: TextStyleUtil.manrope14w400()
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Container(),),
                    Container(
                      height: 53.kh,
                      padding: EdgeInsets.only(left: 12.kw),
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.kh),
                          border: Border.all(color: context.black05)
                      ),
                      child: Center(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          controller: controller.cvvController,
                          validator: (String? val){
                            if(val == null || val.isEmpty){
                              return StringConstant.cvvEmpty;
                            } else if(val.length != 3){
                              return StringConstant.cvv3Digits;
                            } else if(!val.isNumericOnly){
                              return StringConstant.invalidCvv;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: StringConstant.enterFeatures,
                              hintStyle: TextStyleUtil.manrope14w400()
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Container(),),
                  ],
                ),
                16.kheightBox,
                Text(StringConstant.nameOnCard, style: TextStyleUtil.manrope14w500(),),
                16.kheightBox,
                Container(
                  height: 53.kh,
                  padding: EdgeInsets.only(left: 12.kw),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.kh),
                      border: Border.all(color: context.black05)
                  ),
                  child: Center(
                    child: TextFormField(
                      controller: controller.nameController,
                      validator: (String? val){
                        if(val == null || val.isEmpty){
                          return StringConstant.nameCannotBeEmpty;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: StringConstant.enterFeatures,
                          hintStyle: TextStyleUtil.manrope14w400()
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomRedElevatedButton(
          buttonText: StringConstant.proceed,
          height: 56.kh,
          width: MediaQuery.of(context).size.width * 0.9,
          onPressed: () {
            if(controller.formKey.currentState!.validate()){
              controller.addCard();
              // Get.bottomSheet(const AddedSuccessfullBottomSheet(subTitle: StringConstant.cardSavedSuccessfully));
            }
          }),
    );
  }
}