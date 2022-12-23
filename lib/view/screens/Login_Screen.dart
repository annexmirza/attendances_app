import 'package:attendance/constants.dart';
import 'package:attendance/controller/qr_controller.dart';
import 'package:attendance/controller/statecontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'LoginScanResult.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final StateController stateController = Get.put(StateController());
  // final QrController qrController = Get.put(QrController());

  @override
  Widget build(BuildContext context) {
    // qrController.qrPause();

    return GetBuilder<QrController>(
        init: QrController(),
        builder: (qrController) {
          return Scaffold(
              backgroundColor: primarycolor,
              body: !qrController.codeScaned
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Text(
                            "Scan to Login",
                            style: TextStyle(
                                fontSize: 30.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                          SizedBox(
                            height: 0.09.sh,
                          ),
                          /*Scanning Image*/
                          Container(
                            height: 0.4.sh,
                            width: 0.6.sw,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        ExactAssetImage("assets/Scanner.png"),
                                    fit: BoxFit.fill)),
                            child: Container(
                              height: 0.4.sh,
                              width: 0.6.sw,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: QRView(
                                      key: qrController.qrKey,
                                      onQRViewCreated:
                                          qrController.onQRViewCreated),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {
                                stateController.issuccess = false;
                                Get.off(() => LoginScanResult());
                              },
                              child: Container(
                                  child: Text(
                                "Scanned",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))),
                          SizedBox(height: 4.h),
                          Container(
                              child: Text(
                            "Please Wait",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ));
        });
  }
}
