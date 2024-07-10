import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../constants/string_constant.dart';
import '../../../services/dialog_helper.dart';

class QrScanController extends GetxController {
  //TODO: Implement QrScanController

  Barcode? result;
  QRViewController? controller;

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
    controller!.dispose();
  }

  Future<void> scanQR() async{
    try{

    } catch(e){
      print("Error while scanning QR: $e");
      DialogHelper.showError(StringConstant.somethingWentWrong);
    }
  }
}
