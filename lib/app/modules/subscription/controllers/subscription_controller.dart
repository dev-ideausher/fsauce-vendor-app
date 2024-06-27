import 'package:flutter/cupertino.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController{

  TextEditingController promoCodeController = TextEditingController();

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiresController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();


  List<String> totalPlans = [
    StringConstant.silverPlan,
    StringConstant.goldPlan,
    StringConstant.platinumPlan,
  ];

  RxString selectedPlan = "".obs;

  @override
  void onInit(){
    super.onInit();
  }

  @override
  void onReady(){
    super.onReady();
  }

  @override
  void onClose(){
    super.onClose();
    promoCodeController.dispose();
    cardNumberController.dispose();
    cvvController.dispose();
    expiresController.dispose();
    nameController.dispose();
  }


  void goToPurchasePlanView(){
    Get.toNamed(Routes.PURCHASEPLAN);
  }

  void goToPaymentMethodView(){
    Get.toNamed(Routes.PAYMENTDETAILS);
  }

  void goToCardDetailsView(){
    Get.toNamed(Routes.CARDDETAILS);
  }


}