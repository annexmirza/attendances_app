import 'dart:io';

import 'package:attendance/controller/login_controller.dart';
import 'package:attendance/view/screens/LoginScanResult.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrController extends GetxController {
  RegExp regExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  LoginController loginController = Get.put(LoginController());
  bool codeScaned = false;
  String qrError = '';
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      // List data = result!.code.split('*///*');
      controller.pauseCamera();
      // print(data);

      String data = await userExist(result!.code);
      if (data != '') {
        List credentials = data.split('///');
        if (!codeScaned &&
            regExp.hasMatch(credentials[0]) &&
            credentials[1].length >= 6) {
          loginController.login(credentials[0], credentials[1]);
          controller.dispose();
        } else if (!regExp.hasMatch(credentials[0]) ||
            credentials[1].length < 6) {
          Get.off(() => LoginScanResult());
          qrError = 'Contact with Administration';
        }
      } else {
        qrError = 'User is not exist against this QR';
        Get.off(() => LoginScanResult());
      }
      codeScaned = true;
      update();
    });
  }

  userExist(String text) async {
    print(text);
    var snap = await FirebaseFirestore.instance
        .collection('credentials')
        .where('qrText', isEqualTo: text)
        .get();
    if (snap.docs.length > 0) {
      var email = snap.docs[0]['email'];
      var password = snap.docs[0]['password'];
      return "$email///$password";
    } else {
      return '';
    }
  }

  qrPause() {
    // super.reassemble();
    if (controller != null) {
      codeScaned = false;
      qrError = '';
      if (Platform.isAndroid) {
        controller!.pauseCamera();
        controller!.resumeCamera();
      } else if (Platform.isIOS) {
        controller!.resumeCamera();
        // }
      }
    }
    // @override
    // void onClose() {
    //   controller?.dispose();
    //   // TODO: implement onClose
    //   super.onClose();
    // }
  }
}
