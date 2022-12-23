import 'package:attendance/controller/qr_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrLoginPage extends StatelessWidget {
  QrLoginPage({Key? key}) : super(key: key);
  // QRViewController controller;
  QrController qrController = Get.put(QrController());
  @override
  Widget build(BuildContext context) {
    qrController.qrPause();
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: GetBuilder<QrController>(
              init: QrController(),
              builder: (qrController) {
                return Column(
                  children: [
                    // if (qrController.result != null)
                    Text('Scan to login'),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 500,
                          width: 300,
                          child: !qrController.codeScaned
                              ? QRView(
                                  key: qrController.qrKey,
                                  onQRViewCreated: qrController.onQRViewCreated)
                              : qrController.qrError == ''
                                  ? Text('Code Scanned Please Wait')
                                  : Column(
                                      children: [
                                        Text(
                                          '${qrController.qrError}',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              qrController.qrPause();
                                              qrController.update();
                                            },
                                            child: Text('Try Again'))
                                      ],
                                    ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
