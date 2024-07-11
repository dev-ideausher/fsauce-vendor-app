import 'package:flutter/cupertino.dart';
import 'package:fsauce_vendor_app/app/components/added_successfull_bottomsheet.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../constants/string_constant.dart';
import '../../../services/dialog_helper.dart';

class QrScanController extends GetxController {
  //TODO: Implement QrScanController

  Barcode? result;
  QRViewController? qrViewController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  TextEditingController couponCodeController = TextEditingController();
  RxBool canRedeem = false.obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    couponCodeController.dispose();
  }

  void onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
    });
  }

  Future<void> scanQR() async{
    if(result != null){
      try{
        String qrData = result!.code!;

      } catch(e){
        print("Error while scanning QR: $e");
        DialogHelper.showError(StringConstant.somethingWentWrong);
      }
    }
  }

  Future<void> redeemCode() async{
    if(couponCodeController.text.isNotEmpty){
      try{
        var response = await APIManager.redeemCouponCode(code: couponCodeController.text);
        if(response.data['status']){
          Get.bottomSheet(const AddedSuccessfullBottomSheet(subTitle: StringConstant.redeemedSuccessfully));
        } else if(!response.data['status']){
          DialogHelper.showError(response.data['message']);
        }
      } catch(e){
        print("Error while scanning QR: $e");
        DialogHelper.showError(StringConstant.somethingWentWrong);
      }
    }
  }
}
