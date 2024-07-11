import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/components/custom_app_bar.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/constants/string_constant.dart';
import 'package:fsauce_vendor_app/app/services/colors.dart';
import 'package:fsauce_vendor_app/app/services/dio/api_service.dart';
import 'package:fsauce_vendor_app/app/services/responsive_size.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../components/added_successfull_bottomsheet.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dialog_helper.dart';

class QrScanView extends StatefulWidget {
  const QrScanView({super.key});

  @override
  State<QrScanView> createState() => _QrScanViewState();
}

class _QrScanViewState extends State<QrScanView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: StringConstant.scanQRCode),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Stack(
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonImageView(
                        svgPath: ImageConstant.qrScan,
                      ),
                      10.kheightBox,
                      Text(
                        StringConstant.scanQrHeading,
                        style: TextStyleUtil.manrope18w600(),
                      ),
                      10.kheightBox,
                      Text(
                        StringConstant.scanQrSubHeading,
                        textAlign: TextAlign.center,
                        style: TextStyleUtil.manrope14w500(),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                result != null ? Text(result!.code!) : const Text(""),
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.REDEEMCOUPONCODE);
                    },
                      child: Text(StringConstant.enterCouponCodeBelow, style: TextStyleUtil.manrope16w600(color: context.primary01, textDecoration: TextDecoration.underline),))
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // (result != null)
  // ? Text(
  // 'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
  //     : Text('Scan a code'),

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if(result != null){
        scanQR(result!.code!);
      }
    });
  }

  Future<void> scanQR(String data) async{
    if(result != null){
      try{
        Map<String, dynamic> loyaltyCardData = jsonStringToMap(result!.code!);
        Map<String, dynamic> cardData = {
          "user": loyaltyCardData['user'],
          "LoyaltyCard": loyaltyCardData['LoyaltyCard'],
        };
        var response  = await APIManager.scanLoyaltyCard(data: cardData);
        if(response.data['status']){
          Get.bottomSheet(const AddedSuccessfullBottomSheet(subTitle: StringConstant.redeemedSuccessfully));
        } else if(!response.data['status'] && result != null){
          DialogHelper.showError(response.data['message']);
        }
      } catch(e){
        print("Error while scanning QR: $e");
        DialogHelper.showError(StringConstant.somethingWentWrong);
      }
    }
  }

  Map<String, dynamic> jsonStringToMap(String data){
    List<String> str = data.replaceAll("{","").replaceAll("}","").replaceAll("\"","").replaceAll("'","").split(",");
    Map<String,dynamic> result = {};
    for(int i=0;i<str.length;i++){
      List<String> s = str[i].split(":");
      result.putIfAbsent(s[0].trim(), () => s[1].trim());
    }
    return result;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
