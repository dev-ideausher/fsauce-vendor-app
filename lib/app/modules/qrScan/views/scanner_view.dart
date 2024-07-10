import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/qr_scan_controller.dart';

class ScannerView extends GetView<QrScanController>{
  ScannerView({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(),
    );
  }
}