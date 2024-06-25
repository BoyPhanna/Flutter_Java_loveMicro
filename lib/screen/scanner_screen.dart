import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mobile_lm/controller/controller.dart';
import 'package:mobile_lm/screen/home_page.dart';
import 'package:mobile_lm/screen/microfinance_payment.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: Get.width,
          height: Get.height,
        ),
        //Camera
        _buildQrView(context),
        Text(
          "សូមធ្វើការស្គេន",
          style: TextStyle(
            fontSize: 30.sp,
            color: Colors.green,
          ),
        ),

//Back button
        Positioned(
          bottom: 50.h,
          child: ZoomTapAnimation(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 200.h,
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                    color: Color.fromARGB(255, 12, 22, 228).withOpacity(0.6),
                    width: 5),
              ),
              alignment: Alignment.center,
              child: Text(
                "ត្រឡប់",
                style: TextStyle(
                  fontSize: 30.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),

        Positioned(
          top: 80.h,
          child: result != null
              ? Text("Hello " + result!.code.toString())
              : SizedBox(),
        ),
      ],
    ));
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.green,
        borderRadius: 10,
        borderLength: 50,
        borderWidth: 30,
        overlayColor: Colors.white,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen(
      (scanData) async {
        result = scanData;
        if (result != null) {
          await controller.pauseCamera();
          qrControlller.accountId.value = result!.code.toString();

          Navigator.of(context).pop(result!.code);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MicrofinancePaymentPage()));
        }
      },
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
