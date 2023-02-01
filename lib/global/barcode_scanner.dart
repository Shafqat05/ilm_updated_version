import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'app_colors.dart';
import 'common_widgets.dart';

class BarCodeScannerPage extends StatefulWidget {
  const BarCodeScannerPage({Key? key}) : super(key: key);

  @override
  State<BarCodeScannerPage> createState() => _BarCodeScannerPageState();
}

class _BarCodeScannerPageState extends State<BarCodeScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;
  QRViewController? controller;

  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      var height = size.maxHeight;
      var width = size.maxWidth;
      return SafeArea(
        child: Scaffold(
          appBar: myCustomAppBar(
            titleAppBar: 'Scan Book',
            fontSize: width * 0.045,
            context: context,
            backButton: BackButton(
              color: Colors.transparent,
            )
          ),
          body: Container(
            child: Padding(
              padding: EdgeInsets.only(top: width * 0.030),
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        'Scanned value will be showing here',
                        style: TextStyle(
                          fontSize: width * 0.05,
                          color: AppColors.allButtonColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        height: height * 0.72,
                        width: width * 0.98,
                        child: QRView(
                          key: qrKey,
                          onQRViewCreated: _onQRViewCreated,
                          cameraFacing: CameraFacing.back,
                          // overlay: QrScannerOverlayShape(

                          // ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: Text(
                          'SCAN BOOK BARCODE PLEASE',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.04,
                          ),
                        ),
                        color: AppColors.allButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        minWidth: width * 0.9,
                        height: height * 0.074,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

}
